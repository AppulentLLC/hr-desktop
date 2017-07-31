`import Ember from 'ember'`

ProtectedEmployeesDetailTimeSheetController = Ember.Controller.extend
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
    
`export default ProtectedEmployeesDetailTimeSheetController`
