_ = require 'lodash'

number = (x) ->
  unless isNaN x
    -> Number x

bool = (x) ->
  bools = /^true|yes|false|no$/i
  positive = /^true|yes$/i
  if x.match(bools)?
    -> x.match(positive)?

regexp = (x) ->
  if x.match(/^\/.+\/$/)?
    -> new RegExp x[1...-1]

module.exports =

  cast: (x) ->
    (number(x) or bool(x) or regexp(x) or -> x)()

  cammelCase: (spaced) ->
    tokens = spaced.split ' '
    rest = tokens[1..].map (x) -> "#{x[0].toUpperCase()}#{x[1..]}"
    "#{tokens[0]}#{rest}"