`import Ember from 'ember'`

EmployeesDetailTimeClockController = Ember.Controller.extend

    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    init: ->
        $(document).on 'hidden.bs.modal', '#clock-out-modal', =>
            $('#out-modal-datetime').data("DateTimePicker").minDate(false).maxDate(false).defaultDate(false)

            @get('model').get('latestWorkPeriod').rollbackAttributes()
    actions:
        open: (inModal)->
            if @get('model').get 'latestWorkPeriod'
                startTime = @get('model').get('latestWorkPeriod').get('startTime')
                endTime = @get('model').get('latestWorkPeriod').get('endTime')
                $('#out-modal-datetime').data("DateTimePicker").minDate(startTime)
                $('#out-modal-datetime').data("DateTimePicker").maxDate(moment())
            if inModal == 'in-modal'
                $('#in-modal-datetime').data("DateTimePicker").minDate(endTime)
                $('#in-modal-datetime').data("DateTimePicker").maxDate(moment())
        clock: ->
            workPeriodAdapter = Ember.getOwner(@).lookup 'adapter:work-period'
            if @get('model').get('latestWorkPeriod')
                workPeriodAdapter.getLatest(@get('model').get 'id').then (data) =>
                    @store.pushPayload data
                    latestWorkPeriod = @get('model').get('latestWorkPeriod')
                    if $('#clock-out-modal').hasClass('in')
                        if latestWorkPeriod.get('endTime')
                            @set 'modalErrorMessage', 'Already clocked out for this work period.'  
                        else
                            datetime = $('#out-modal-datetime').data('DateTimePicker').date()
                            latestWorkPeriod.set 'endTime', datetime._d
                        
                    else if $('#clock-in-modal').hasClass('in')
                        
                        datetime = $('#in-modal-datetime').data('DateTimePicker').date()
                        latestWorkPeriod = @store.createRecord 'work-period',
                            employee: @get 'model'
                            startTime: datetime._d
                    
                    latestWorkPeriod.save().then =>
                        $('#clock-out-modal').modal('hide')
                        $('#clock-in-modal').modal('hide')
           
            else
                workPeriodAdapter.getLatest()
                    .then (data) =>
                        @store.pushPayload data
                        datetime = $('#in-modal-datetime').data('DateTimePicker').date()
                        latestWorkPeriod = @store.createRecord 'work-period',
                            employee: @get 'model'
                            startTime: datetime._d
                        
                        latestWorkPeriod.save().then =>
                            $('#clock-in-modal').modal('hide')
        
        recordPrevious: ->
            datetimeIn = $('#start-datetime').data('DateTimePicker').date()
            datetimeOut = $('#end-datetime').data('DateTimePicker').date()
            @store.createRecord 'work-period',
                            employee: @get 'model'
                            startTime: datetimeIn._d
                            endTime: datetimeOut._d
            .save().then (result) =>
                $('#previous-modal').modal('hide')
            .catch (error) =>
                @set 'modalErrorMessage', error.errors.status
            
            
            
`export default EmployeesDetailTimeClockController`
