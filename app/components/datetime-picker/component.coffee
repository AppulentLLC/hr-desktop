`import Ember from 'ember'`

DatetimePickerComponent = Ember.Component.extend
    didInsertElement: ->
        
        @$("##{@get 'widgetId'}").datetimepicker
            defaultDate: moment()
            inline: true
            sideBySide: true
        
        
`export default DatetimePickerComponent`
