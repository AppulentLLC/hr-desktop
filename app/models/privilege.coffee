`import DS from 'ember-data'`

Privilege = DS.Model.extend

    hrRole: DS.attr 'string'
    isGlobalAdmin: DS.attr 'boolean'

    user: DS.belongsTo 'user', async: true
    
`export default Privilege`
