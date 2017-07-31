`import Ember from 'ember'`
`import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin'`

AuthLoginRoute = Ember.Route.extend UnauthenticatedRouteMixin,
    setupController: (controller) ->
        controller.set 'credentials', {username: null, password: null}
        controller.set 'loginMessage', null
    actions:
        authenticate: ->
            authenticator = 'authenticator:application'
            {username, password} = @get 'controller.credentials'
            @get('session').authenticate authenticator, username, password
            .then =>
                sessionData = @get('session.data')
                sessionData.authenticated.user = {username}
                @get('session.store').persist sessionData
            .catch (error) =>
                console.log error
                if error.error_description
                    message = error.error_description
                else if error.error
                    message = error.error
                @set 'controller.loginMessage',
                    message.replace(/[.]/,'')
`export default AuthLoginRoute`
