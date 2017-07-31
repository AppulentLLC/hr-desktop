`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

EmployeesDetailTimeSheetRoute = Ember.Route.extend RouteMixin,
    
    perPage: 13
    
    model: (params) ->
        params.paramMapping =
            perPage: 'page_size'
            
        params.employee = @modelFor('protected.employees.detail').get 'id'
        params.order = '-start_time'
        @findPaged 'work-period', params
 
        
`export default EmployeesDetailTimeSheetRoute`
