`import Ember from 'ember'`

ProtectedAdminTerminalsNewRoute = Ember.Route.extend
    
    actions:
        addTerminal: ->
            newUsername = 'terminal'
            @store.query 'user', {username_contains: newUsername}
            .then (result) =>
                if result.get('length') > 0
                    numSimilar = 0
                    result.forEach (user) =>
                        numSimilar++
                    newUsername += (numSimilar)
                newUser = @store.createRecord 'user', username: newUsername
                newUser.save().then =>
                
                    newPrivilege = @store.createRecord 'privilege', {hrRole: 't'}
                    newPrivilege.set 'user', newUser
                    newPrivilege.save().then =>
                        @transitionTo 'protected.admin.terminals.change-password', newUser.id

`export default ProtectedAdminTerminalsNewRoute`
