`import Ember from 'ember'`

ProtectedAdminSettingsRoute = Ember.Route.extend
    
    beforeModel: ->
         @controllerFor('protected.admin.settings').set 'alert', ''

`export default ProtectedAdminSettingsRoute`
