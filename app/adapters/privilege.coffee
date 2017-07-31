`import ApplicationAdapter from './application'`
`import config from '../config/environment'`

PrivilegeAdapter = ApplicationAdapter.extend
    
    namespace: config.APP.AUTH_API_NAMESPACE
    
`export default PrivilegeAdapter`
