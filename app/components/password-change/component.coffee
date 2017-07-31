`import Ember from 'ember'`

PasswordChangeComponent = Ember.Component.extend
    
    didInsertElement: ->
        @$('#password-form').validator().on 'submit', (event) =>
            if event.isDefaultPrevented()
                # handle the invalid form...
                @set 'errorMessage', 'Please correct the errors in the form'
            else
                # everything looks good!
                event.preventDefault()
                @sendAction 'action'

`export default PasswordChangeComponent`
