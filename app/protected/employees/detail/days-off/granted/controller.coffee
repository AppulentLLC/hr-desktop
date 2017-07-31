`import Ember from 'ember'`
`import config from '../../../../../config/environment'`

ProtectedEmployeesDetailDaysOffGrantedController = Ember.Controller.extend

    protected: Ember.inject.controller 'protected'
    
    isViewingAdmin: Ember.computed.reads 'protected.isViewingAdmin'
    
    detail: Ember.inject.controller('protected.employees.detail')
    
    employee: Ember.computed.reads('detail.employee')    
    
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    token: Ember.computed.reads 'session.data.authenticated.access_token'
    
    host: config.APP.API_HOST
    
    namespace: config
    
    requestData: {}
    
    init: ->
        @set 'requestData.employee', @get 'employee'
        
    datarequest: Ember.computed 'employee', ->
        
        @set 'requestData.employee', @get 'employee'
        @get 'requestData'


    # queryParams: ["page", "perPage"]

    # binding the property on the paged array
    # to the query params on the controller
    page: Ember.computed.alias "model.page"
    perPage: Ember.computed.alias "model.perPage"
    totalPages: Ember.computed.alias "model.meta.pagination.pages"

    # set default values, can cause problems if left out
    # if value matches default, it won't display in the URL
    page: 1
    perPage: 10


`export default ProtectedEmployeesDetailDaysOffGrantedController`
