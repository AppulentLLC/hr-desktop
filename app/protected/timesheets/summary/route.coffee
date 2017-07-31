`import Ember from 'ember'`

TimesheetsSummaryRoute = Ember.Route.extend

    service: Ember.inject.service 'protected.timesheets.summary'
    
    minStartDate: Ember.computed.reads 'service.minStartDate'
    
    maxStartDate: Ember.computed.reads 'service.maxStartDate'
    
    model: ->
        @get('service').initWeeks(moment().format 'YYYY-MM-DD')
        Ember.RSVP.hash
            workPeriods: @store.query 'work-period',
                min_start_date: @get 'minStartDate'
                max_start_date: @get 'maxStartDate'
            daysOff: @store.query 'day-off',
                min_date: @get 'minStartDate'
                max_date: @get 'maxStartDate'
`export default TimesheetsSummaryRoute`
