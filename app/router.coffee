import Ember from 'ember'
import config from './config/environment'

Router = Ember.Router.extend
  location: config.locationType
  rootURL: config.rootURL

Router.map ->
    @route 'auth', ->
        @route 'login'
        @route 'logout'

    @route 'protected', ->
        @route 'admin', ->
            @route 'settings'
            @route 'terminals', ->
                @route 'change-password', path: '/:user_id', ->
                @route 'new'
            @route 'days-off-requests'
        @route 'employees', ->
            @route 'new'
            @route 'detail', path: '/:employee_id', ->
                @route 'info', ->
                    @route 'edit'
                @route 'time', ->
                    @route 'sheet'
                    @route 'clock'
                @route 'days-off', ->
                    @route 'requests'
                    @route 'granted'
                @route 'days-off-requests'
                @route 'user', ->
                    @route 'change-password'
            
        @route 'timesheets', ->
            @route 'week', ->
                @route 'detail', path: '/:date'
            @route 'summary'

export default Router
