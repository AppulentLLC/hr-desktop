import Ember from 'ember'
import Resolver from './resolver'
import loadInitializers from 'ember-load-initializers'
import config from './config/environment'
import OAuth2 from 'ember-simple-auth/authenticators/oauth2-password-grant'
import PagedRemoteArray from 'ember-cli-pagination/remote/paged-remote-array'
import {ChangeMeta} from 'ember-cli-pagination/remote/mapping'

#Ember.MODEL_FACTORY_INJECTIONS = true

App = Ember.Application.extend
    modulePrefix: config.modulePrefix,
    podModulePrefix: config.podModulePrefix,
    Resolver: Resolver

loadInitializers(App, config.modulePrefix);

inflector = Ember.Inflector.inflector
inflector.irregular('day-off', 'days-off')

OAuth2.reopen 
    makeRequest: (url, data) ->
        clientData = localStorage.getItem 'client_data'
        if clientData
            clientData = JSON.parse clientData
            @requestToken data, clientData.client_id, clientData.client_secret
        else
            Ember.$.ajax
                url: config.APP.API_HOST + '/authentication/applications/?name=desktop'
                type: 'GET'
                dataType: 'json'
                contentType: 'application/json'
            .then (result) =>
                clientData = result[0]
                localStorage.setItem 'client_data', JSON.stringify(clientData)
                @requestToken data, clientData.client_id, clientData.client_secret
   
    requestToken: (data, clientId, clientSecret) ->
        Ember.$.ajax
            url: config['ember-simple-auth'].serverTokenEndpoint
            type: 'POST'
            data: data
            dataType: 'json'
            contentType: 'application/x-www-form-urlencoded'
            headers: 
                'Authorization': 'Basic ' + btoa "#{clientId}:#{clientSecret}"
                    
PagedRemoteArray.reopen
    totalPages: Ember.computed.alias 'meta.pagination.pages'
    
ChangeMeta.reopen
    validate: (meta) ->
        return
        
        
export default App

