`import Ember from 'ember'`

EmployeesNewController = Ember.Controller.extend
    init: ->
        @set 'newEmployee', {}
        @set 'newPrivilege', @store.createRecord 'privilege'
    
    actions:
        saveEmployee: ->
            newEmployee = @get 'newEmployee'
            newUsername = newEmployee.firstName.charAt(0) + 
                          newEmployee.lastName
            newUsername = newUsername.toLowerCase().replace(/[^a-z0-9]/g,'')
            # See if other users have similar usernames.
            @store.query 'user', {username_contains: newUsername}
            .then (result) =>
                if result.get('length') > 0
                    numSimilar = 0
                    result.forEach (user) =>
                        num = user.get('username').charAt(-1)
                        if not isNaN(num)
                            if newUsername == user.get('username').slice 0, -1
                                numSimilar++
                    newUsername += (numSimilar + 1)
                newUser = @store.createRecord 'user', username: newUsername
                newUser.save().then =>
                    newPrivilege = @get 'newPrivilege'
                    newPrivilege.set 'user', newUser
                    newPrivilege.save()
                    
                    newEmployee = @store.createRecord 'employee' , newEmployee
                    newEmployee.set 'user', newUser                    
                    newEmployee.save().then =>
                        @transitionToRoute 'protected.employees.detail.info', 
                                            newEmployee.get 'id'
                        @set 'newEmployee', {}

`export default EmployeesNewController`
