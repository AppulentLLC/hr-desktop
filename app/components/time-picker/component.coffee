`import Ember from 'ember'`

TimePickerComponent = Ember.Component.extend
    didInsertElement: ->
        @_super(arguments...)
        @$('#timepicker').timepicker()

        

`export default TimePickerComponent`
