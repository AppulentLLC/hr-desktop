`import Ember from 'ember'`

ProtectedEmployeesDetailInfoController = Ember.Controller.extend
    
    detailsController: Ember.inject.controller 'protected.employees.detail'
    
    canEdit: Ember.computed.reads 'detailsController.canEdit'
    
`export default ProtectedEmployeesDetailInfoController`
