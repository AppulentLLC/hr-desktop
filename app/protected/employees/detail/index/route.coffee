`import Ember from 'ember'`

EmployeesDetailIndexRoute = Ember.Route.extend
    beforeModel: ->
        @transitionTo 'protected.employees.detail.info'

`export default EmployeesDetailIndexRoute`
