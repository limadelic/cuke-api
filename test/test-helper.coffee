global.p = (x) -> console.log JSON.stringify x
global.m = (x) -> p (name for name of x)

global.relative = (file) -> "#{__dirname}/../src/#{file}"

global.sinon = require 'sinon'
global._ = require 'lodash'
