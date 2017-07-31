`import Ember from 'ember'`

ProtectedEmployeesIndexRoute = Ember.Route.extend
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    beforeModel: ->
        unless @get 'user.hasManagerPrivileges'
            @transitionTo 'protected'
        

`export default ProtectedEmployeesIndexRoute`
