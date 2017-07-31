`import Ember from 'ember'`

TimesheetSummaryTableComponent = Ember.Component.extend
    didInsertElement: ->
        $('#summary-table .collapse-row').hide(1)
        $('#summary-table').on 'click', '.expand-or-collapse', (event) =>
            el = $(event.target)
            if el.hasClass 'glyphicon-triangle-right'
                el.removeClass 'glyphicon-triangle-right'
                  .addClass 'glyphicon-triangle-bottom'
                #el.closest('tbody').find('.collapse-td').hide()
                el.closest('.row').siblings().removeClass('hidden')
            else if el.hasClass 'glyphicon-triangle-bottom'
                el.removeClass 'glyphicon-triangle-bottom'
                  .addClass 'glyphicon-triangle-right'
                el.closest('.row').siblings().addClass('hidden')
`export default TimesheetSummaryTableComponent`
