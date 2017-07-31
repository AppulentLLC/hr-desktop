`import Ember from 'ember'`

ProtectedIndexRoute = Ember.Route.extend
    beforeModel: ->
        @transitionTo 'protected.employees'

`export default ProtectedIndexRoute`
