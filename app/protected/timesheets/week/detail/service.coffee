`import Ember from 'ember'`

TimesheetsWeekService = Ember.Service.extend
    init: ->
        @_super(arguments...)
        @set 'dateFormat', 'YYYY-MM-DD'

    initWeek: (date) ->
        format = @get 'dateFormat'
        @set 'date', date
        @set 'startOfWeek', moment(date).startOf('isoWeek').format format
        @set 'endOfWeek', moment(date).endOf('isoWeek').format format
            
    daysInWeek: Ember.computed 'startOfWeek', ->
        days = []
        for num in [0..6]
            date = moment(@get 'startOfWeek').add num, 'days'
            days.push date.format(@get 'dateFormat')
        days


`export default TimesheetsWeekService`
