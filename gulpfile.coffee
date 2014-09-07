gulp        = require 'gulp'
requireDir  = require 'require-dir'
dir         = requireDir './task'

gulp.task 'default', ['icon']

gulp.task 'watch', ->
  o = debounceDelay: 10000
  gulp.watch ['src/*.html', 'src/*.css', 'src/map.sketch/Data'], o, ['icon']
