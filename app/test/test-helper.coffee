# Libraries

global = require 'global'
global.Promise = require 'bluebird'
global.jQuery = require 'jQuery'
global.Overworld = require 'overworld'
global.Qiita = require('qiita-js');
global.React = require('react/addons');
global.TestUtils = React.addons.TestUtils
global._ = require('lodash');
global.EventEmitter = require('events').EventEmitter;
global.assert = require 'power-assert'

sinon = require 'sinon'
jade = require 'react-jade'
cheerio = require 'cheerio'
jsdom = require('jsdom')
MockLocalStorage = require 'mock-localStorage'

# stub stores
global.localStorage = new MockLocalStorage()

# require jade
require.extensions['.jade'] = (module, filename) ->
  module.exports = jade.compileFile(filename)

# DSL
global.q = (fn) -> new Promise (done) -> fn(done)
# test helper
global.$ = (html) -> cheerio.load html

# jsdom
global.stubWindow = ->
  beforeEach ->
    global.window = jsdom.jsdom('<html><body></body></html>').parentWindow
    global.document = window.document
    global.navigator = window.navigator

  afterEach ->
    delete global.window
    delete global.document
    delete global.navigator

beforeEach ->
  @sinon = sinon.sandbox.create()

afterEach ->
  @sinon.restore()

# Stub database
initSchema = require 'minimongo-schema'
Repository = require 'mz-repository/adapters/minimongo'
schema = require '../schema'
schema.databases[0].type = 'memoryDb'

global.stubDatabase = ->
  beforeEach (done) ->
    initSchema(schema).then (dbs) ->
      global.db = new Repository.Database(dbs[0])
      global.Item = db.getCollection('items')
      global.Team = db.getCollection('teams')
      done()

  afterEach ->
    delete global.db
    delete global.Item
    delete global.Team

global.FactoryDog = require 'factory-dog'
schema.databases[0].collections.forEach (col) ->
  obj = {}
  for k, v of col.params
    key =
      if k[k.length-1] is '?'
        k[0...k.length-1]
      else
        k
    obj[key] = v

  name =
    if col.name[col.name.length-1] is 's'
      col.name[0...col.name.length-1]
    else
      col.name

  FactoryDog.define name, obj
