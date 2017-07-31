`import Ember from 'ember'`

EmployeesRoute = Ember.Route.extend
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    model: ->
        Ember.RSVP.hash
            employees: @store.findAll 'employee'
            users: @store.findAll 'user'
            privilege: @store.findAll 'privilege'
            userSetting: @store.findAll 'user-setting'
            newReqeusts: @store.query 'days-off-request', 
                seen:'False'
    
    beforeModel: ->
        workPeriodAdapter = Ember.getOwner(@).lookup 'adapter:work-period'
        workPeriodAdapter.getLatest()
            .then (data) =>
                @store.pushPayload data
                
    afterModel: ->
        unless @get 'user.hasManagerPrivileges'
            @transitionTo 'protected.employees.detail', @get 'user.employee'
                
    
`export default EmployeesRoute`
