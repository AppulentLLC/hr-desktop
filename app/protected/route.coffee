`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProtectedRoute = Ember.Route.extend AuthenticatedRouteMixin,
    
    
    model: ->
        Ember.RSVP.hash
            employees: @store.findAll 'employee'
            users: @store.findAll 'user'
            privilege: @store.findAll 'privilege'
            userSetting: @store.findAll 'user-setting'
            newReqeusts: @store.query 'days-off-request', 
                seen:'False'
            
    afterModel: ->
        @_super(arguments...)
        username = @get 'session.data.authenticated.user.username'
        userObject = @store.peekAll('user').filter (user) ->
            user.get('username') == username
        .objectAt(0)
        @set 'session.user', userObject
    
    actions:
        error: (error, transition) ->
          if (error && error.status == 400)
            #error substate and parent routes do not handle this error
            return @transitionTo('modelNotFound')

          #Return true to bubble this event to any parent route.
          return true

`export default ProtectedRoute`
