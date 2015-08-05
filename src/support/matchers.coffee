should = require 'should'
_ = require 'lodash'

dotted = (x) -> x.replace /\s+/g, '.'

exports.shouldExp = ({actual, matcher, expected}) ->
  expected ?= ''
  "#{dotted actual}.should.#{dotted matcher}(#{expected});"

exports.any = any = (items, query) ->
  items = [items] unless _.isArray items
  _.find(items, query) or
  _.findWhere(items, query)

should.Assertion.add 'contain', (val) ->

  shouldContain = (x) =>
    should.exist any(@obj, x),
      "could not find #{s x} in #{s @obj}"

  if _.isArray val
  then _.map val, shouldContain
  else shouldContain val