`import Ember from 'ember'`

TimesheetsWeekIndexRoute = Ember.Route.extend
    beforeModel: ->
        @transitionTo 'protected.timesheets.week.detail', moment().format 'YYYY-MM-DD'

`export default TimesheetsWeekIndexRoute`
