`import Ember from 'ember'`

ProtectedAdminTerminalsChangePasswordRoute = Ember.Route.extend

    setupController: (controller, model) ->
        @_super(arguments...)
        controller.set 'newPassword', ''
        
    model: (params) ->
        @store.peekRecord 'user', params.user_id
        
    actions:
        savePassword: ->
            model = @modelFor 'protected.admin.terminals.change-password'
            data = 
                id: model.get 'id'
                password: @get 'controller.newPassword'
            userAdapter = Ember.getOwner(@).lookup 'adapter:user'
            userAdapter.changePassword(data)
            .then =>
                @transitionTo 'protected.admin.terminals'

`export default ProtectedAdminTerminalsChangePasswordRoute`
