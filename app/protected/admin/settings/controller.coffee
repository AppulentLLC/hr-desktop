import Ember from 'ember'

ProtectedAdminSettingsController = Ember.Controller.extend
    
    session: Ember.inject.service 'session'
    
    user: Ember.computed.reads 'session.user'
    
    alert: ''

    init: ->
        
        @set 'userSetting', @store.peekRecord 'user-setting', @get 'user.userSetting.id'
        if not @get 'userSetting'
            @set 'userSetting', @store.createRecord 'user-setting'
            @get('userSetting').set 'user', @get 'user'
    
    days: [
            {value: 1, name: '1'},
            {value: 2, name: '2'},
            {value: 3, name: '3'},
            {value: 4, name: '4'},
          ]
    views: [
            {value: false, name: 'Cards'},
            {value: true, name: 'Table'},
          ]
    actions:
        saveSettings: ->
            userSetting = @get 'userSetting'
            userSetting.save().then =>
                @set 'alert', 'Settings Saved'

        selectSummery: (value, event) ->
            @set 'user.userSetting.summaryWeeks', value

        selectSummaryView: (value, event) ->
            @set 'user.userSetting.summaryView', value
            
export default ProtectedAdminSettingsController
