`import Ember from 'ember'`
`import RouteMixin from 'ember-cli-pagination/remote/route-mixin'`

ProtectedEmployeesDetailDaysOffGrantedRoute = Ember.Route.extend RouteMixin,


    setupController: (controller, model) ->
        @_super(arguments...)
        controller.set 'employeeId', @modelFor('protected.employees.detail').get 'id'
    
    perPage: 13
    
    model: (params) ->
        params.paramMapping =
            perPage: 'page_size'
            
        params.employee = @modelFor('protected.employees.detail').get 'id'
        params.order = '-date'
        @findPaged('day-off', params)
    

    actions:
        resetModel: ->            
            @controller.set 'model', @model({})
            

`export default ProtectedEmployeesDetailDaysOffGrantedRoute`
