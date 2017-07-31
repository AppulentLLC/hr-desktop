`import Ember from 'ember'`

ProtectedAdminTerminalsController = Ember.Controller.extend
   
    privileges: Ember.computed 'model.@each.hrRole','model',->
        @get('model').filter (privilege) ->
            privilege.get('hrRole') == 't'

`export default ProtectedAdminTerminalsController`
