`import Ember from 'ember'`
`import ApplicationController from '../application/controller'`

ProtectedController = ApplicationController.extend
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    isViewingAdmin: false
    
    sortedEmployees: Ember.computed 'model.employees.@each.fullName', ->
        if @get('model')
            @get('model').employees.sortBy('fullName')
        
    searchedEmployees: Ember.computed 'employeeSearch', 'sortedEmployees.@each.fullName', ->
            search = @get('employeeSearch').toLowerCase()
            @get('sortedEmployees').filter (employee) ->
                employee.get('fullName').toLowerCase().indexOf(search) != -1
                
    employees: Ember.computed 'employeeSearch', 'sortedEmployees', 'searchedEmployees', ->
            if @get 'employeeSearch'
                @get 'searchedEmployees'
            else
                @get 'sortedEmployees'
    
    expiresAt: Ember.computed.reads 'session.data.authenticated.expires_at'
    
    unseenRequests: Ember.computed 'model.newReqeusts', ->
        count = 0
        newRequest = @get 'model.newReqeusts'
        newRequest.forEach (req) ->
            if req.get('seen') == false
                count += 1
        count
        
        
            
    processIdle: ->
        idleTime = localStorage.getItem 'idleTime'
        idleTime++
        if idleTime == 13
            $('#idle-modal').modal('show')
        else if idleTime >= 15
            @get('session').invalidate()
        localStorage.setItem 'idleTime', idleTime
        
    init: ->
        localStorage.setItem 'idleTime', 0
        # Invalidate the session when the token expires.
        Ember.run.later =>
            @get('session').invalidate()
        , (@get('expiresAt') - Date.now() - 1000)
        

        #Increment the idle time counter every minute.
        setInterval =>
            @processIdle()
        , 60000
        
        #Zero the idle timer on mouse movement.
        $(document).mousemove (e) =>
            localStorage.setItem 'idleTime', 0
        #Zero the idle timer on keypress.
        $(document).keypress (e) =>
            localStorage.setItem 'idleTime', 0
        
    actions:
        logoutIdle: ->
            @get('session').invalidate()
        dismiss: ->
            $('#idle-modal').modal('hide')
    
    
`export default ProtectedController`
