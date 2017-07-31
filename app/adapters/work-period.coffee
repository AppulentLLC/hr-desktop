`import Ember from 'ember'`
`import ApplicationAdapter from './application'`

WorkPeriodAdapter = ApplicationAdapter.extend
    getLatest: (employeeId) ->
        url = "#{@get 'host'}/#{@get 'namespace'}/work-periods/latest/"
        if employeeId
            url += "?employee=#{employeeId}"
        @ajax url, 'GET'
                
`export default WorkPeriodAdapter`
