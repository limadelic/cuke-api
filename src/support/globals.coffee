global._ = require 'lodash'

global.s = (x) -> JSON.stringify x
global.p = (x) -> console.log s x
global.m = (x) ->
  p x.__proto__.constructor.name
  p _.sortBy (name for name of x), (x) -> x

global.config =
  src: 'src'
  api: 'localhost'