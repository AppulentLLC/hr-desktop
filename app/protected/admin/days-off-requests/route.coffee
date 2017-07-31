`import Ember from 'ember'`

ProtectedAdminDaysOffRequestsRoute = Ember.Route.extend

    model: ->
        @store.findAll 'days-off-request'
    
    actions:
        openRequest: (request) ->
            @controllerFor('protected.admin.days-off-requests').set 'currentRequest', request
            
            $('#day-off-from-datetime').data("DateTimePicker").minDate(false).maxDate(false).defaultDate(false)
            $('#day-off-to-datetime').data("DateTimePicker").minDate(false).maxDate(false).defaultDate(false)
            
            $('#day-off-from-datetime').data("DateTimePicker").defaultDate(false)
            $('#day-off-to-datetime').data("DateTimePicker").defaultDate(false)
            
            $('#day-off-from-datetime').data("DateTimePicker").defaultDate(moment(request.get 'startDate'))
            $('#day-off-to-datetime').data("DateTimePicker").defaultDate(moment(request.get 'endDate'))
            
            $('#day-off-from-datetime').data("DateTimePicker")
                                       .minDate(moment(request.get 'startDate'))
                                       .maxDate(moment(request.get 'endDate'))
            $('#day-off-to-datetime').data("DateTimePicker")
                                     .minDate(moment(request.get 'startDate'))
                                     .maxDate(moment(request.get 'endDate'))
            
            $('#days-off-modal').modal('show')
          

`export default ProtectedAdminDaysOffRequestsRoute`
