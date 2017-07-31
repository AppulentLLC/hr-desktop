`import OAuth2PasswordGrant from 'ember-simple-auth/authenticators/oauth2-password-grant'`

ApplicationAuthenticator = OAuth2PasswordGrant.extend
    refreshAccessTokens: false
     
`export default ApplicationAuthenticator`
