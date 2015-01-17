global = require 'global'
require './setup/extensions'

global.app = new Overworld.Portal
app.link 'main',   require './scenes/main'

resetStorages = require './utils/reset-storages'
initDb = require './setup/init-db'
require './setup/keybinds'

window.addEventListener 'load', ->
  # resetStorages().then ->
    app.mount document.querySelector('#content-container')
    initDb().then ->
      app.transition('main', {})
