`import Ember from 'ember'`

EmployeesDetailInfoEditRoute = Ember.Route.extend

    activate: -> 
        @controllerFor('protected.employees.detail.info').set 'isEditing', true
        
    deactivate: ->
        @controllerFor('protected.employees.detail.info').set 'isEditing', false
    
    
`export default EmployeesDetailInfoEditRoute`
