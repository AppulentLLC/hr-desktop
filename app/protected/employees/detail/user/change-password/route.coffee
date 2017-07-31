`import Ember from 'ember'`

ProtectedEmployeesDetailUserChangePasswordRoute = Ember.Route.extend
    
    setupController: (controller, model) ->
        @_super(arguments...)
        controller.set 'newPassword', ''
        
    actions:
        savePassword: ->
            model= @modelFor('protected.employees.detail')
            data = 
                id: model.get 'user.id'
                password: @get 'controller.newPassword'
            userAdapter = Ember.getOwner(@).lookup 'adapter:user'
            userAdapter.changePassword(data)
            .then =>
                @transitionTo 'protected.employees.detail.info'

`export default ProtectedEmployeesDetailUserChangePasswordRoute`
