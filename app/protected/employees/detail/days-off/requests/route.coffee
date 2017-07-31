`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

ProtectedEmployeesDetailDaysOffRequestsRoute = Ember.Route.extend RouteMixin,
    
    perPage: 13
 
    model: (params) ->
        params.paramMapping =
            perPage: 'page_size'
            
        params.employee = @modelFor('protected.employees.detail').get 'id'
        params.order = '-start_date'
        @findPaged('days-off-request', params)

`export default ProtectedEmployeesDetailDaysOffRequestsRoute`
