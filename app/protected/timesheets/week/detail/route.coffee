`import Ember from 'ember'`

TimesheetsWeekDetailRoute = Ember.Route.extend

    service: Ember.inject.service 'protected.timesheets.week.detail'
    
    dateFormat: Ember.computed.reads 'service.dateFormat'
    
    minStartDate: Ember.computed.reads 'service.startOfWeek'
    
    model: (params) ->
        format = @get 'dateFormat'
        @get('service').initWeek(params.date)
        minStartDate = @get 'minStartDate'
        maxStartDate = moment(minStartDate).add(7, 'days').format format
        
        Ember.RSVP.hash
            workPeriods: @store.query 'work-period',
                min_start_date: minStartDate
                max_start_date: maxStartDate
                order: 'start_time'
            daysOff: @store.query 'day-off',
                min_date: minStartDate
                max_date: maxStartDate
                order: 'date'

    setupController: (controller, model) ->
        @_super(arguments...)
        controller.set 'workPeriods', Ember.A(model.workPeriods.toArray())
`export default TimesheetsWeekDetailRoute`
