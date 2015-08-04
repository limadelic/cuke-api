_ = require 'lodash'

{ cast } = require './cast'

hasHeader = (x) -> x[0][0].match /^\[.+\]$/
cleanHeaders = (x) ->
  x[0] = _.map x[0], (h) -> h.replace /^\[(.+)\]$/, '$1'

array = (t) ->
  return if t[0].length isnt 1 or hasHeader t
  _.map _.flatten(t), cast

object = (t) ->
  return if t[0].length isnt 2 or hasHeader t
  _.zipObject _.map t, (x) -> [x[0], cast x[1]]

list = (t) ->
  cleanHeaders t
  _.map t[1..], (row) ->
    _.zipObject t[0], _.map row, cast

module.exports = (t) ->
  return unless t?
  t = t.raw()
  array(t) or object(t) or list(t)