`import Ember from 'ember'`

ProtectedAdminDaysOffRequestsController = Ember.Controller.extend

    protected: Ember.inject.controller()
    
    unseenRequests: Ember.computed.alias 'protected.unseenRequests'
    
    isViewingAdmin: Ember.computed.reads 'protected.isViewingAdmin'

`export default ProtectedAdminDaysOffRequestsController`
