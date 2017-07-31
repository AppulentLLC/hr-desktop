`import Ember from 'ember'`

TimesheetsSummaryController = Ember.Controller.extend
    protected: Ember.inject.controller()
    
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    employees: Ember.inject.controller 'protected.employees'
    
    employeesArray: Ember.computed.reads 'protected.employees'
    
    service: Ember.inject.service 'protected.timesheets.summary'
    
    dateFormat: Ember.computed.reads 'service.dateFormat'
    
    weeksArray: Ember.computed.reads 'service.weeksArray'
    
    workPeriods: Ember.computed.reads 'model.workPeriods'
    
    daysOff: Ember.computed.reads 'model.daysOff'
    
    userView: Ember.computed.reads 'user.userSetting.summaryView'
    
    summaryView: Ember.computed 'userView', ->
        userViews = @get 'userView'
        if userViews
            userViews
        else
            true
    
    employeeSummaries: Ember.computed 'workPeriods.@each.hoursWorked',
        'employeesArray.[]', 'weeksArray', 'daysOff.[]',->
            format = @get 'dateFormat'
            weeksArray = @get 'weeksArray'
            result = Ember.A([])
            @get('employeesArray').forEach (employee) =>
                # Initialize an object containing the employee and a set of keys
                # for the beginning of each week.
                summary = 
                    employee: employee
                    regularHours: 0
                    overtime: 0
                    paidDaysOff: holiday: 0, vacation: 0, personal: 0, total: 0
                    grandTotal: 0
                    weeks: Ember.A([])
                workPeriods = @get 'workPeriods'
                daysOff = @get 'daysOff'
                ownWP = workPeriods.filterBy 'employee.id',  employee.get 'id'
                ownDO = daysOff.filterBy 'employee.id',  employee.get 'id'
                weeksArray.forEach (week, index) =>
                    summary.weeks[index] =
                        start: week
                        regular: 0
                        overtime: 0
                        paidDaysOff: 
                            holiday: 0, vacation: 0, personal: 0, total: 0
                        total: 0

                    weekObject = summary.weeks[index]
                    weekStart = moment(week, format)
                    weekEnd = moment(week, format).add 7, 'days' 
                    
                    currentWorkPeriods = ownWP.filter (wp) ->
                        weekStart <= moment(wp.get 'startTime') < weekEnd
                    
                    currentWorkPeriods.forEach (workPeriod) ->
                        hoursWorked = workPeriod.get 'hoursWorked'
                        weekObject.total += hoursWorked
                        summary.grandTotal += hoursWorked
                    
                    weekTotal = weekObject.total
                    if weekTotal > 40
                        weekObject.regular = 40
                        weekObject.overtime = weekTotal - 40
                        summary.regularHours += 40
                        summary.overtime += weekTotal - 40
                    else
                        weekObject.regular = weekTotal
                        summary.regularHours += weekTotal
                    if weekObject.regular != 0
                        weekObject.regular = weekObject.regular.toFixed 3
                    if weekObject.overtime != 0
                        weekObject.overtime  = weekObject.overtime.toFixed 3
                    
                    currentDaysOff = ownDO.filter (dayOff) ->
                        weekStart <= moment(dayOff.get 'utcDate') < weekEnd
                        
                    currentDaysOff.forEach (dayOff) ->
                        if not dayOff.get('isPaid')
                            return
                        hours = dayOff.get 'hours'
                        weekObject.total += hours
                        summary.grandTotal += hours
                        key = dayOff.get('typeDisplay').toLowerCase()
                        weekObject.paidDaysOff[key] += hours
                        weekObject.paidDaysOff.total += hours
                        summary.paidDaysOff[key] += hours
                        summary.paidDaysOff.total += hours
                    
                    if weekObject.total != 0
                        weekObject.total = weekObject.total.toFixed 3
                        

                if summary.regularHours != 0
                    summary.regularHours  = summary.regularHours.toFixed 3
                if summary.grandTotal != 0
                    summary.grandTotal  = summary.grandTotal.toFixed 3
                if summary.overtime > 0
                    summary.overtime  = summary.overtime.toFixed 3
                result.push summary
            result



    summariesExport: Ember.computed 'employeeSummaries', ->
        summaries = @get 'employeeSummaries'
        summaries = summaries.map (summary) ->
            employee = summary.employee
            obj = 
                'External ID': employee.get 'payrollId'
                Name: employee.get 'fullName'
                Regular: summary.regularHours
                Overtime: summary.overtime
                Holiday: summary.paidDaysOff.holiday
                Vacation: summary.paidDaysOff.vacation
                Personal: summary.paidDaysOff.personal
                Total: summary.grandTotal
            obj
        summaries.toArray()

    actions:
        showCardView: ->
            $('#timesheets-summaries').removeClass('hidden')
            $('#timesheet-table').addClass('hidden')
            
        showTableView: ->
            $('#timesheets-summaries').addClass('hidden')
            $('#timesheet-table').removeClass('hidden')

`export default TimesheetsSummaryController`
