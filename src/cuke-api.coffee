http = require 'superagent'
async = require 'async'

require './support/globals'
table = require './support/table'
t = require './support/tokens'
{ shouldExp } = require './support/matchers'

steps = ->

  url = (res) -> "http://#{config.api}/#{res}"

  auth = (req) ->
    req.set 'Authorization', "Bearer #{@token or '53cr3t'}"

  record = (done) -> (err, res) ->
    @error = err if err
    @response = res
    @results = res?.body
    done?()

  @When /^GET "([^"]*)"$/, (resource, done) ->
    http.get url resource
    .use auth
    .end record done

  @When /^DEL "([^"]*)"$/, (resource, done) ->
    http.del url resource
    .use auth
    .end record done

  post = (resource, payload, done) ->
    http.post url resource
    .use auth
    .send payload
    .end record done

  @When /^POST "([^"]*)"$/, (resource, payload, done) ->
    payload = JSON.parse payload
    post resource, payload, done

  @When /^POST "([^"]*)":$/, (resource, objects, done) ->
    objects = table objects
    objects = [objects] unless _.isArray objects
    postit = (x, done) -> post resource, x, done
    async.each objects, postit, done

  @Then t.x("(#{t.text}) #{t.should} (#{t.arg})"), (actual, matcher, expected) ->
    p shouldExp { actual, matcher, expected: 'expected' }

#  @Then t.x("(#{t.text}) #{t.should}"), (actual, matcher) ->
#    p shouldExp { actual, matcher }
#    eval shouldExp { actual, matcher }

  @Then t.x("(#{t.text}) #{t.should}:"), (actual, matcher, expected) ->
    expected = table expected
    eval shouldExp { actual, matcher, expected: 'expected' }

module.exports = (config={}) ->
  _.merge global.config, config
  steps
