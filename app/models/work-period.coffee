`import DS from 'ember-data'`

WorkPeriod = DS.Model.extend
    # Attributes
    startTime: DS.attr 'date'
    endTime: DS.attr 'date'
    adjustment: DS.attr 'number'
    note: DS.attr 'string'
    isDeleted: DS.attr 'boolean'
    
    # Relations:
    employee: DS.belongsTo 'employee', async: true
    
    # Computed properties:
    hoursWorked: Em.computed 'startTime', 'endTime', 'isDeleted', 'adjustment', ->
        startTime = @get 'startTime'
        endTime = @get 'endTime'
        if (null in [startTime, endTime]) or (@get 'isDeleted')
            0
        # Get the difference in milliseconds and convert to hours.
        else
            hoursWorked = (endTime - startTime) / (1000 * 60 * 60)
            adjustment = @get 'adjustment'
            if adjustment
                hoursWorked += (adjustment / 60)
            hoursWorked

            
    clockedOutNextDay: Em.computed 'startTime', 'endTime', ->
        endTime = @get 'endTime'
        if endTime == null
            return false
        startDate = moment(@get 'startTime').format 'YYYY-MM-DD'
        endDate = moment(endTime).format 'YYYY-MM-DD'
        startDate != endDate
    
`export default WorkPeriod`
