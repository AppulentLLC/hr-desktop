`import DS from 'ember-data'`

UserSetting = DS.Model.extend

    summaryText: DS.attr 'string'
    summaryWeeks: DS.attr 'number'
    summaryView: DS.attr 'boolean'

    user: DS.belongsTo 'user', async: true

`export default UserSetting`
