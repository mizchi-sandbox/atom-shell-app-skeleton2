# Exposed libraries to global
global = require 'global'
global.Promise = require 'bluebird'
global.jQuery = require 'jQuery'
global.Overworld = require 'overworld'
global.React = require('react');
global._ = require('lodash');
shell = require 'shell'

# require jade
jade = require('react-jade')
require.extensions['.jade'] = (module, filename) ->
  module.exports = jade.compileFile(filename)

# DSL
global.q = (fn) -> new Promise (done) -> fn(done)

# Hack `a` tag
jQuery ->
  jQuery('body').on 'click', 'a', (ev) ->
    ev.preventDefault()
    link = ev.target.href
    shell.openExternal link
