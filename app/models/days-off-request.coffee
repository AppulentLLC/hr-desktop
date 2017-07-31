`import DS from 'ember-data'`

DaysOffRequest = DS.Model.extend
  
    startDate: DS.attr 'string'
    endDate: DS.attr 'string'
    requestType: DS.attr 'string'
    isPaid: DS.attr 'boolean'
    note: DS.attr 'string'
    status: DS.attr 'string'
    seen: DS.attr 'boolean'
    seenAt: DS.attr 'date'
    
    updatedBy: DS.belongsTo 'user', async: true
    requestedAt: DS.attr 'date'
    updatedAt: DS.attr 'date'
    
    employee: DS.belongsTo 'employee', async: true
    daysOff: DS.hasMany 'day-off', async: true
    
    typeDisplay: Ember.computed 'requestType', ->
        hash = hy: 'Holiday', vn: 'Vacation', pl: 'Personal'
        hash[@get 'requestType']
        

`export default DaysOffRequest`
