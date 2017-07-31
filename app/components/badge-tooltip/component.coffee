`import Ember from 'ember'`

BadgeTooltipComponent = Ember.Component.extend
    didInsertElement: ->
        @_super(arguments...)
        @$('[data-toggle="tooltip"]').tooltip
            container: 'body'
            
    formattedDateTime: Ember.computed 'lastDateTime', ->
        moment(@get 'lastDateTime').format 'YYYY-MM-DD hh:mmA'

`export default BadgeTooltipComponent`
