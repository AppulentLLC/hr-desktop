`import Ember from 'ember'`

TimesheetsWeekDetailController = Ember.Controller.extend
    protected: Ember.inject.controller()
    
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    employees: Ember.computed.reads 'protected.employees'
    
    service: Ember.inject.service 'protected.timesheets.week.detail'
    
    date: Ember.computed.alias 'service.date'
    
    daysInWeek: Ember.computed.reads 'service.daysInWeek'
    
    dateFormat: Ember.computed.reads 'service.dateFormat'
    
    minStartDate: Ember.computed.reads 'service.startOfWeek'
    
    groupedWorkPeriods: Ember.computed 'workPeriods.@each.hoursWorked',
        'employees.[]', 'model.allWorkPeriods.[]', ->
            result = Ember.A([])
            @get('employees').forEach (employee) =>
                employeeGroup = {employee, totalHours: 0, dates: {}}
                @get('daysInWeek').forEach (date) =>
                    employeeGroup.dates[date] = 
                        workPeriods: Ember.A([])
                        daysOff: Ember.A([])
                workPeriods = @get 'workPeriods'
                daysOff = @get 'model.daysOff'
                filterKey = 'employee.id'
                id = employee.get 'id'
                employeeWorkPeriods = workPeriods.filterBy filterKey, id
                employeeWorkPeriods.forEach (workPeriod) ->
                    startTime = workPeriod.get 'startTime'
                    startDate = moment(startTime).format 'YYYY-MM-DD'
                    employeeGroup.totalHours += workPeriod.get 'hoursWorked'
                    employeeGroup.dates[startDate].workPeriods.push workPeriod
                employeeDaysOff = daysOff.filterBy filterKey, id
                employeeDaysOff.forEach (dayOff) ->
                    startDate = dayOff.get 'utcDate'
                    if dayOff.get 'isPaid'
                        employeeGroup.totalHours += dayOff.get 'hours'
                    employeeGroup.dates[startDate].daysOff.push dayOff    
                if employeeGroup.totalHours != 0
                    employeeGroup.totalHours = employeeGroup
                                               .totalHours.toFixed 3
                result.push employeeGroup
            result
            
    dateChanged: Ember.observer 'date', ->
        newDateStr = @get 'date'
        if newDateStr.length != 10
            return false
        newDate = moment newDateStr, 'YYYY-MM-DD'
        if newDateStr != newDate.format 'YYYY-MM-DD'
            return false
        if newDate.format('YYYY-MM-DD') == 'Invalid date'
            return false
        startOfWeek = newDate.startOf('isoWeek')
        startOfWeekStr = startOfWeek.format 'YYYY-MM-DD'
        if startOfWeekStr != @get('service').get('startOfWeek')
            @transitionToRoute 'protected.timesheets.week.detail',
                               startOfWeekStr
           
    init: ->
        $(document).on 'hidden.bs.modal', '#work-period-modal', =>
            @get('currentWorkPeriod').rollbackAttributes()
                
        $(document).on 'shown.bs.modal', '#work-period-modal', =>
            workPeriod = @get 'currentWorkPeriod'     
            if workPeriod.get('endTime') == null
                $('#clock-out').data('DateTimePicker')
                               .minDate(workPeriod.get 'startTime')
                $('#clock-out').data('DateTimePicker')
                               .maxDate(moment(workPeriod.get 'startTime')
                               .add(1, 'day'))
                $('#clock-out').data('DateTimePicker')
                               .defaultDate(workPeriod.get 'startTime')
          
    actions:
        goToPreviousWeek: ->
            format = @get 'dateFormat'
            startDate = moment(@get 'minStartDate')
            previousStartDate = startDate.subtract(7, 'days').format format
            @set 'date', previousStartDate
            
        goToNextWeek: ->
            format = @get 'dateFormat'
            startDate = moment(@get 'minStartDate')
            nextStartDate = startDate.add(7, 'days').format format
            @set 'date', nextStartDate

        setCurrentWorkPeriod: (workPeriod) ->
            @set 'currentWorkPeriod', workPeriod
    
        clockOut: ->
            workPeriod = @get('currentWorkPeriod')
            datetime = $('#clock-out').data('DateTimePicker').date()
            workPeriod.set 'endTime', datetime._d

        updateCurrentWorkPeriod: ->
            workPeriod = @get('currentWorkPeriod')
            workPeriod.save()
            $('#work-period-modal').modal('hide')
            
        inModal: (employee, date) ->
            @set 'currentEmployee', employee
            $('#in-modal-datetime').data('DateTimePicker')
                               .maxDate(false).minDate(false)
            
            $('#in-modal-datetime').data('DateTimePicker')
                               .maxDate(moment(date).endOf('day')).minDate(moment(date).startOf('day'))
                               
        clockIn: ->
            datetime = $('#in-modal-datetime').data('DateTimePicker').date()
            workPeriod = @store.createRecord 'work-period', 
                            employee: @get 'currentEmployee'
                            startTime: datetime._d
            workPeriod.save().then =>
                $('#clock-in-modal').modal('hide')
                @get('workPeriods').pushObject(workPeriod)
                
            
`export default TimesheetsWeekDetailController`
