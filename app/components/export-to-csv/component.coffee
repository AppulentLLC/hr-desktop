`import Ember from 'ember'`

ExportToCsvComponent = Ember.Component.extend

    actions:
        exportCSV: ->
            csv = Papa.unparse(@get('summariesExport'))
            uri = 'data:text/csv;charset=utf-8,' + escape(csv)

            downloadLink = document.createElement("a")
            downloadLink.href = uri
            date=moment().format 'YYYY-MM-DD'
            downloadLink.download = "#{date}.csv"
            document.body.appendChild(downloadLink)
            downloadLink.click()
            document.body.removeChild(downloadLink)
    

`export default ExportToCsvComponent`
