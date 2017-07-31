`import Ember from 'ember'`

ProtectedAdminRoute = Ember.Route.extend
    
    activate: -> 
        @controllerFor('protected').set 'isViewingAdmin', true
        
    deactivate: ->
        @controllerFor('protected').set 'isViewingAdmin', false
    
    urlChanged: Ember.observer 'router.currentPath', ->
        if @get('router.currentPath') == 'protected.admin.index'
            @controller.set 'isOnMainPage', true
        else
            @controller.set 'isOnMainPage', false
            
`export default ProtectedAdminRoute`
