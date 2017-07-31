`import Ember from 'ember'`

# This function receives the params `params, hash`
momentFormatAdd = (params) ->
    time = params[0]
    amount = params[1]
    unit = params[2]
    moment(time, 'YYYY-MM-DD').add(amount, unit).format 'YYYY-MM-DD'

MomentFormatAddHelper = Ember.Helper.helper momentFormatAdd

`export { momentFormatAdd }`

`export default MomentFormatAddHelper`
