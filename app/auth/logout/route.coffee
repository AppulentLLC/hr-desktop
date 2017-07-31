`import Ember from 'ember'`


AuthLogoutRoute = Ember.Route.extend
    session: Ember.inject.service 'session'
    
    activate: ->
        @get('session').invalidate()

`export default AuthLogoutRoute` 
