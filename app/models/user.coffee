`import DS from 'ember-data'`
`import Ember from 'ember'`

User = DS.Model.extend
    username: DS.attr 'string'
    password: DS.attr 'string'
    
    employee: DS.belongsTo 'employee', async: true
    privilege: DS.belongsTo 'privilege', async: true
    userSetting: DS.belongsTo 'user-setting', async: true
    
    hasAdminPrivileges: Ember.computed 'privilege.hrRole', 'privilege.isGlobalAdmin', ->
        @get('privilege.isGlobalAdmin') or (@get('privilege.hrRole') in ['a'])
        
    hasManagerPrivileges: Ember.computed 'privilege.hrRole', 'privilege.isGlobalAdmin', ->
        @get('privilege.isGlobalAdmin') or (@get('privilege.hrRole') in ['m', 'a'])
    
    isGlobalAdmin: Ember.computed.reads 'privilege.isGlobalAdmin'
    
    isHrAdmin: Ember.computed 'privilege.hrRole', ->
        @get('privilege.hrRole') == 'a'
        
    isHrManager: Ember.computed 'privilege.hrRole', ->
        @get('privilege.hrRole') == 'm'
        
    isEmployee: Ember.computed 'privilege.hrRole', ->
        @get('privilege.hrRole') == 'e'

`export default User`
