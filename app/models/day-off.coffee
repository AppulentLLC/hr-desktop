`import DS from 'ember-data'`

DayOff = DS.Model.extend

    date: DS.attr 'date'
    hours: DS.attr 'number'
    dayOffType: DS.attr 'string'
    isPaid: DS.attr 'boolean'
    note: DS.attr 'string'
    
    employee: DS.belongsTo 'employee', async: true
    daysOffRequest: DS.belongsTo 'days-off-request', async: true
    
    utcDate: Ember.computed 'date', ->
        moment(@get 'date').utc().format 'YYYY-MM-DD'
    
    typeDisplay: Ember.computed 'dayOffType', ->
        hash = hy: 'Holiday', vn: 'Vacation', pl: 'Personal'
        hash[@get 'dayOffType']

`export default DayOff`
