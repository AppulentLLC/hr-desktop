`import Ember from 'ember'`

EmployeeInfoRoute = Ember.Route.extend
    setupController: (controller, model) ->
        @_super(arguments...)
        controller.set 'isEditing', false

    actions:
        editEmployee: ->
            #@controller.set 'isEditing', true
            @transitionTo 'protected.employees.detail.info.edit'

`export default EmployeeInfoRoute`
