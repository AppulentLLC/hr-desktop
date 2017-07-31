`import Ember from 'ember'`
`import DS from 'ember-data'`

Employee = DS.Model.extend
    # Attributes:
    payrollId: DS.attr 'string'
    firstName: DS.attr 'string'
    lastName: DS.attr 'string'
    ssn: DS.attr 'string'
    primaryPhone: DS.attr 'string'
    secondaryPhone: DS.attr 'string'
    addressStreet: DS.attr 'string'
    addressSecondary: DS.attr 'string'
    city: DS.attr 'string'
    state: DS.attr 'string'
    postalCode: DS.attr 'string'
    isActive: DS.attr 'boolean'
    createdAt: DS.attr 'date'
    
    # Relations:
    workPeriods: DS.hasMany 'work-period', async: true
    user: DS.belongsTo 'user', async: true
    daysOff: DS.hasMany 'day-off', async: true
    daysOffRequests: DS.hasMany 'days-off-request', async: true
    
    # Computed properties:
    fullName: Ember.computed 'firstName', 'lastName', ->
        "#{@get 'firstName'} #{@get 'lastName'}"
        
    latestWorkPeriod: Ember.computed 'workPeriods.[]', ->
        ownWorkPeriods = @get 'workPeriods'
        length = ownWorkPeriods.get 'length'
        if length > 0
            ownWorkPeriods.sortBy('startTime').objectAt(length - 1)
        else
            false
            
            
    stateDisplay: Ember.computed 'state', ->
        state = @get 'state'
        states = [{value: '', name: ''},{value: 'MI', name: 'Michigan'},{value: 'AL', name: 'Alabama'}, 
            {value: 'AZ', name: 'Arizona'}, {value: 'AR', name: 'Arkansas'},
            {value: 'CA', name: 'California'}, {value: 'CO', name: 'Colorado'}, {value: 'CT', name: 'Connecticut'}, 
            {value: 'DE', name: 'Delaware'}, {value: 'DC', name: 'District of Columbia'}, 
            {value: 'FL', name: 'Florida'}, {value: 'GA', name: 'Georgia'}, {value: 'ID', name: 'Idaho'}, 
            {value: 'IL', name: 'Illinois'}, {value: 'IN', name: 'Indiana'}, {value: 'IA', name: 'Iowa'}, 
            {value: 'KS', name: 'Kansas'}, {value: 'KY', name: 'Kentucky'}, {value: 'LA', name: 'Louisiana'}, 
            {value: 'ME', name: 'Maine'}, {value: 'MD', name: 'Maryland'}, {value: 'MA', name: 'Massachusetts'}, 
            {value: 'MN', name: 'Minnesota'}, {value: 'MS', name: 'Mississippi'}, 
            {value: 'MO', name: 'Missouri'}, {value: 'MT', name: 'Montana'}, {value: 'NE', name: 'Nebraska'}, 
            {value: 'NV', name: 'Nevada'}, {value: 'NH', name: 'New Hampshire'}, {value: 'NJ', name: 'New Jersey'}, 
            {value: 'NM', name: 'New Mexico'}, {value: 'NY', name: 'New York'}, {value: 'NC', name: 'North Carolina'},
            {value: 'ND', name: 'North Dakota'}, {value: 'OH', name: 'Ohio'}, {value: 'OK', name: 'Oklahoma'}, 
            {value: 'OR', name: 'Oregon'}, {value: 'PA', name: 'Pennsylvania'}, {value: 'RI', name: 'Rhode Island'}, 
            {value: 'SC', name: 'South Carolina'}, {value: 'SD', name: 'South Dakota'}, 
            {value: 'TN', name: 'Tennessee'}, {value: 'TX', name: 'Texas'}, {value: 'UT', name: 'Utah'}, 
            {value: 'VT', name: 'Vermont'}, {value: 'VA', name: 'Virginia'}, {value: 'WA', name: 'Washington'}, 
            {value: 'WV', name: 'West Virginia'}, {value: 'WI', name: 'Wisconsin'}, {value: 'WY', name: 'Wyoming'}]
        result = states.filter (obj) ->
            obj.value == state
        result[0].name

`export default Employee`
