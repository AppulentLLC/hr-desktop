`import Ember from 'ember'`

ProtectedAdminController = Ember.Controller.extend
    
    protected: Ember.inject.controller()
    
    unseenRequests: Ember.computed.alias 'protected.unseenRequests'
    
    isOnMainPage: true
    
    session: Ember.inject.service 'session'
    
    user: Ember.computed.reads 'session.user'
    
`export default ProtectedAdminController`
