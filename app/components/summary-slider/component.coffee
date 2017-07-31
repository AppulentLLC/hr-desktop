`import Ember from 'ember'`

SummarySliderComponent = Ember.Component.extend

    service: Ember.inject.service 'protected.timesheets.summary'
    
    weeks: Ember.computed.alias 'service.weeks'
    
    session: Ember.inject.service()
    
    user: Ember.computed.reads 'session.user'
    
    didInsertElement: ->
        weeks = @get 'user.userSetting.summaryWeeks'
        if not weeks
            weeks = 2
        mySlider = $("#slide-sum").slider
            ticks: [1, 2, 3, 4]
            ticks_labels: ['1 week', '2 weeks', '3 weeks', '4 weeks']
            min: 1
            max: 4
            step: 1
            value: weeks
            
        mySlider.on 'change', =>
            @set 'weeks', (4 - mySlider.slider('getValue'))
            
`export default SummarySliderComponent`
