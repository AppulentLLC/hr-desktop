`import Ember from 'ember'`

EmployeesDetailInfoEditController = Ember.Controller.extend
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    privilege: Ember.computed.alias 'model.user.privilege'
    
    actions:
        updateEmployee: ->
            $('.square').collapse('show')
            setInterval =>
                $('.square').collapse('hide')
            , 2000
            @get('model').save().then =>
                @get('privilege.content').save().then =>
                    @transitionToRoute 'protected.employees.detail.info'

`export default EmployeesDetailInfoEditController`
