`import Ember from 'ember'`

EmployeesDetailRoute = Ember.Route.extend

    model: (params) -> @store.find 'employee', params.employee_id
    
`export default EmployeesDetailRoute`
