`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`
IndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
    afterModel: ->
        @transitionTo 'protected.employees'
`export default IndexRoute`
