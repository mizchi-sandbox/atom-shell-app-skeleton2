gulp = require('gulp')
downloadatomshell = require('gulp-download-atom-shell')

gulp.task 'downloadatomshell', (cb) ->
  downloadatomshell
    version: '0.20.6'
    outputDir: 'binaries'
  , cb

gulp.task 'default', ['downloadatomshell']
