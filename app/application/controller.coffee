`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
`export default ApplicationController`
