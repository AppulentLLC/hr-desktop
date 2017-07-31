`import Ember from 'ember'`
`import ApplicationAdapter from './application'`
`import config from '../config/environment'`

UserAdapter = ApplicationAdapter.extend
    
    session: Ember.inject.service()
    
    namespace: config.APP.AUTH_API_NAMESPACE
    
    token: Ember.computed.reads 'session.data.authenticated.access_token'
    
    changePassword: (data)->
        Ember.$.ajax
            url: "#{@get 'host'}/#{@get 'namespace'}/users/#{data.id}/"
            type: 'PATCH'
            data: data
            dataType: 'json'
            contentType: 'application/x-www-form-urlencoded'
            headers:
                "Authorization": "Bearer " + @get('token')

`export default UserAdapter`
