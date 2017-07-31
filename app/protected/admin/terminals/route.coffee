`import Ember from 'ember'`

ProtectedAdminTerminalsRoute = Ember.Route.extend
    
    model: ->
        @store.peekAll('privilege')
       
`export default ProtectedAdminTerminalsRoute`
