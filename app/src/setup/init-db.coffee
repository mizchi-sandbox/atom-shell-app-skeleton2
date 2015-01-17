Repository = require 'mz-repository/adapters/minimongo'
initSchema = require('minimongo-schema')
schema = require '../../schema'
global = require 'global'

module.exports = initDb = (forceClear = false) -> new Promise (done) ->
  if forceClear then localStorage.clear()
  initSchema(schema, forceClear).then (dbs) ->
    global.db = new Repository.Database(dbs[0])
    global.Tweet = db.getCollection('tweets')
    done()
