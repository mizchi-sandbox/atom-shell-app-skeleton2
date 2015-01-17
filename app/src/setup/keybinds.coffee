_ = require 'lodash'
fs = require 'fs'
userSettingPath = process.env.HOME + '/.config/tw/keymap.json'
userKeymap =
  if fs.existsSync userSettingPath
    require userSettingPath
  else
    {}

defaultKeymap =
  'j': 'main:select-next-item'
  'k': 'main:select-previous-item'
  'e': 'main:open-item'

keymap = _.defaults defaultKeymap, userKeymap

# TODO: fix at web build
# Mousetrap has require hacks with window exists
require 'mousetrap'

for key, v of keymap then do (key, v) ->
  Mousetrap.bind key, ->
    emitter = app.getActiveEmitter()
    emitter.emit v
