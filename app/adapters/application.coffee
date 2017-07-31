`import DS from 'ember-data'`
`import config from '../config/environment'`
`import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin'`

ApplicationAdapter = DS.JSONAPIAdapter.extend DataAdapterMixin,
    authorizer: 'authorizer:application'
    
    host: config.APP.API_HOST
    
    namespace: config.APP.HR_API_NAMESPACE
    
    buildURL: ->
        url = @_super.apply @, arguments
        if(url.charAt url.length - 1) != '/'
            url += '/'
        url

`export default ApplicationAdapter`
