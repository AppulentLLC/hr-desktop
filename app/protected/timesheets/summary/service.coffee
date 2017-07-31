`import Ember from 'ember'`

TimesheetsSummaryService = Ember.Service.extend


    init: ->
        @_super(arguments...)
        @set 'dateFormat', 'YYYY-MM-DD'
        @set 'weeks', 2
        
    initWeeks: (date) ->
        format = @get 'dateFormat'
        fourWeeksAgo = moment().startOf('isoWeek').subtract 4, 'weeks'
        minStartDate = fourWeeksAgo.format format
        maxStartDate = moment().startOf('isoWeek').format format
        @setProperties {minStartDate, maxStartDate}
            
    weeksArray: Ember.computed 'minStartDate', 'maxStartDate', 'weeks', ->
        weeks = @get 'weeks'
        format = @get 'dateFormat'
        result = Ember.A([])
        [weeks..3].forEach (num) =>
            startOfWeek = moment(@get 'minStartDate', format).add num, 'weeks'
            result.push startOfWeek.format(format)
        result
        

`export default TimesheetsSummaryService`
