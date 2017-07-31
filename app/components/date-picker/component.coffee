`import Ember from 'ember'`

DatePickerComponent = Ember.Component.extend
    didInsertElement: ->
        @$('#date-picker').datepicker
            autoclose: true
            forceParse: false
            format: 'yyyy-mm-dd'
            orientation: 'bottom auto'

            

`export default DatePickerComponent`

