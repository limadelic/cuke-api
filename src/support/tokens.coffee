_ = require 'lodash'

t =
  x: (expr) -> new RegExp "^#{expr}$"
  g: (expr) -> new RegExp "#{expr}", "g"
  lit: '"[^"]*"'
  id: '\\w+'
  should: 'should ([^:]+)'
  text: '[^@"]+'

t.var = "@#{t.id}"
t.arg = "#{t.lit}|#{t.var}"
t.args = (args) ->
  matcher = t.g "(?:(#{t.arg})(?:#{t.text})?)"
  _.flatten(x[1..] while x = matcher.exec args)


module.exports = t