`import Ember from 'ember'`
`import config from '../../config/environment'`

DaysOffComponent = Ember.Component.extend
    token: Ember.computed.reads 'session.data.authenticated.access_token'
    
    host: config.APP.API_HOST
    namespace: config.APP
    session: Ember.inject.service()
    user: Ember.computed.reads('session.user')
    store: Ember.inject.service()    
    title: ''
    
    hours: 8
    daysInWeek: {   
                    "Monday": true, "Tuesday": true, "Wednesday": true,
                    "Thursday": true, "Friday": true, "Saturday": false,
                    "Sunday": false
                }
    dayOffTypes:   
                    vn: 'Vacation' 
                    hy: 'Holiday'
                    pl: 'Personal'
                    
    dayOffType: Ember.computed 'requestData.requestType', ->
        if  @get('requestData.requestType')
            @get('requestData.requestType')
        else
            'vn'
            
    isPaid: Ember.computed 'requestData.isPaid', ->
        if  @get('requestData.isPaid') != undefined
            @get('requestData.isPaid')
        else
            true
    note: Ember.computed 'requestData.note', ->
        if @get('requestData.note')
            @get('requestData.note')
        else
            ''
    didInsertElement: ->
        
        @_super(arguments...)
        @$('[data-toggle="tooltip"]').tooltip
            container: 'body'
            
        $('#day-off-from-datetime').data('DateTimePicker').options('format':'YYYY MM DD')
        $('#day-off-to-datetime').data('DateTimePicker').options('format':'YYYY MM DD')
        #$('#day-off-from-datetime').datetimepicker({useCurrent: false})
        $("#day-off-from-datetime").on "dp.change", (e) ->
            $('#day-off-to-datetime').data("DateTimePicker").minDate(e.date)
        $("#day-off-to-datetime").on "dp.change", (e) ->
            $('#day-off-from-datetime').data("DateTimePicker").maxDate(e.date)
            
        
    unseenFunction: (seen) ->
        unseen = @get 'unseenRequests'
        if not seen
            if @get('unseenRequests') > 0
                @set 'unseenRequests', unseen-1

    approved: Ember.computed 'requestData.status', ->
        status = @get 'requestData.status'
        if status == 'Approved'
            $('#rejectBtn').prop 'disabled', false
            $('#saveBtn').prop 'disabled', true
                         .attr('title', 'Already Approved')
            true
        else
            false
    
    rejected: Ember.computed 'requestData.status', ->
        status = @get 'requestData.status'
        if status == 'Rejected'
            $('#saveBtn').prop 'disabled', false
            $('#rejectBtn').prop('disabled', true)
                           .attr('title', 'Already Rejected')
            true
        else
            false    
    actions:
        selectType: (value, event) ->
            @set 'dayOffType' , value

        saveDays: ->
            
            daysInWeek = @get 'daysInWeek'
            days = Ember.A([])
            data =
                data:
                    type: 'days-off'
                    attributes:
                        dates: []
                        hours: @get 'hours'
                        dayOffType: @get 'dayOffType'
                        isPaid: @get 'isPaid'
                    relationships:
                        
                        employee:
                            data:
                                type: 'employee'
                                id: @get 'requestData.employee.id'
                        daysOffRequest:
                            data:
                                type: 'days-off-requests'
                                id:  @get 'requestData.id'
                

            startDate = moment($('#day-off-from-datetime').data('DateTimePicker').date())
            endDate = moment($('#day-off-to-datetime').data('DateTimePicker').date())
            numberOfDays = moment.duration(endDate - startDate).days()
            dayString = startDate.format 'YYYY-MM-DD'
            for num in [0..numberOfDays]
                day = moment(dayString)
                day = day.add(num,'days')
                for key, value of daysInWeek
                    if(day.format('dddd') == key and value == true)
                        data.data.attributes.dates.push day.toDate()
            Ember.$.ajax
                url: "#{@get 'host'}/#{@get 'namespace.HR_API_NAMESPACE'}/days-off/add_day_off/"
                type: 'POST'
                data: JSON.stringify(data)
                dataType: 'json'
                contentType: 'application/vnd.api+json'
                headers:
                    "Authorization": "Bearer " + @get('token')
            .then =>
                Ember.$('#days-off-modal').modal 'hide'
                currentRoute = Ember.getOwner(@).lookup("router:main").get('currentRouteName') 
                if currentRoute == 'protected.employees.detail.days-off.granted'
                    @sendAction 'action'
                else
                    @unseenFunction(@get 'requestData.seen')
                    @set 'requestData.status', 'Approved'
                    @set 'requestData.seen', 'true'
                    @set 'requestData.statusAt', moment()
                    @get('requestData').save()
            
        requestDaysOff: ->
            data =
                employee: @get 'user.employee'
                startDate: moment($('#day-off-from-datetime').data('DateTimePicker').date()).format 'YYYY-MM-DD'
                endDate: moment($('#day-off-to-datetime').data('DateTimePicker').date()).format 'YYYY-MM-DD'
                isPaid: @get 'isPaid'
                requestType: @get 'dayOffType'
                note: @get 'note'
                status: 'Pending'
                
            @get('store').createRecord 'days-off-request', data
            .save().then =>
                Ember.$('#days-off-modal').modal 'hide'

        rejectDays: ->
            daysInWeek = @get 'daysInWeek'
            data =
                data:
                    type: 'days-off'
                    attributes:
                        dates: []
                        hours: @get 'hours'
                        dayOffType: @get 'requestData.requestType'
                        isPaid: @get 'isPaid'
                    relationships:
                        employee:
                            data:
                                type: 'employee'
                                id: @get 'requestData.employee.id'
                        daysOffRequest:
                            data:
                                type: 'days-off-request'
                                id:  @get 'requestData.id'
                                
            startDate = moment(@get 'requestData.startDate')
            endDate = moment(@get 'requestData.endDate')
            numberOfDays = moment.duration(endDate - startDate).days()
            dayString = startDate.format 'YYYY-MM-DD'
            for num in [0..numberOfDays]
                day = moment(dayString)
                day = day.add(num,'days')
                for key, value of daysInWeek
                    if(day.format('dddd') == key and value == true)
                        data.data.attributes.dates.push day.toDate()

            Ember.$.ajax
                url: "#{@get 'host'}/#{@get 'namespace.HR_API_NAMESPACE'}/days-off/delete_day_off/"
                type: 'POST'
                data: JSON.stringify(data)
                dataType: 'json'
                contentType: 'application/vnd.api+json'
                headers:
                    "Authorization": "Bearer " + @get('token')
             .then =>
                @unseenFunction(@get 'requestData.seen')
                @set 'requestData.status', 'Rejected'
                @set 'requestData.seen', 'true'
                @set 'requestData.statusAt', moment()
                @get('requestData').save().then =>
                    Ember.$('#days-off-modal').modal 'hide'
            
`export default DaysOffComponent`
