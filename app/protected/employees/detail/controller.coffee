`import Ember from 'ember'`
`import ApplicationController from '../../../application/controller'`

ProtectedEmployeesDetailController = ApplicationController.extend
    
    session: Ember.inject.service 'session'
    
    user: Ember.computed.reads 'session.user'
    
    employee: Ember.computed.reads 'model'
    
    canEdit: Ember.computed 'user', 'employee', 'privilege', ->
        if (@get 'user.isGlobalAdmin')
            true
        else if (@get 'user.hasAdminPrivileges')
            if @get('user.employee.id') == @get 'employee.id'
                true
            else if @get('employee.user.hasAdminPrivileges')
                false
            else
                true
       
        else if (@get 'user.hasManagerPrivileges')
            if @get('user.employee.id') == @get 'employee.id'
                true
            else if @get('employee.user.hasManagerPrivileges')
                false
            else
                true
        else true


`export default ProtectedEmployeesDetailController`
