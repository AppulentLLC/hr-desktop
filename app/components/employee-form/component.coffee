`import Ember from 'ember'`

EmployeeFormComponent = Ember.Component.extend
    session: Ember.inject.service 'session'
    
    user: Ember.computed.reads 'session.user'
    
    states: [{value: '', name: ''},{value: 'MI', name: 'Michigan'},{value: 'AL', name: 'Alabama'}, {value: 'AZ', name: 'Arizona'}, 
            {value: 'AR', name: 'Arkansas'},
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
            
    errorMessage: null
            
    didInsertElement: ->
        employee = @get 'employee'
        privilege = @get 'privilege'
        @$('#employee-form').validator().on 'submit', (event) =>
            if event.isDefaultPrevented()
                # handle the invalid form...
                @set 'errorMessage', 'Please correct the errors in the form'
            else
                # everything looks good!
                event.preventDefault()
                @sendAction 'action'
                        
        @$('#ssn-input').inputmask('999-99-9999')
        @$('.phone-input').inputmask('(999)999-9999')
        
        $('#permission').on 'click', 'button', ->
            $('#permission button').removeClass 'active'
            $(this).addClass 'active'
            if($(this).text() == 'Manager')
                privilege.set 'hrRole', 'm'
            else if($(this).text() == 'Admin')
                privilege.set 'hrRole', 'a'
            else
                privilege.set 'hrRole', 'e'

    actions:
        selectState: (value, event) ->
            @set 'employee.state', value
            
`export default EmployeeFormComponent`
