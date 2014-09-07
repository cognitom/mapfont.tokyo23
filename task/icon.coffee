gulp        = require 'gulp'
rename      = require 'gulp-rename'
sketch      = require 'gulp-sketch'
iconfont    = require 'gulp-iconfont'
consolidate = require 'gulp-consolidate'
merge       = require 'merge-stream'

SRC      = './src'
DIST     = './dist'
FONTNAME = 'mapfont.tokyo23'

gulp.task 'icon', ->
  gulp.src "#{SRC}/map.sketch"
    .pipe sketch
      export: 'artboards'
      formats: 'svg'
    .pipe iconfont fontName: FONTNAME
    .on 'codepoints', (codepoints) ->
      options =
        glyphs: codepoints
        fontName: FONTNAME
        fontPath: './'
        className: 'tokyo23'
      merge (
        gulp.src "#{SRC}/map.css"
          .pipe consolidate 'lodash', options
          .pipe rename basename: FONTNAME
          .pipe gulp.dest "#{DIST}/"
        gulp.src "#{SRC}/map.html"
          .pipe consolidate 'lodash', options
          .pipe rename basename:'index'
          .pipe gulp.dest "#{DIST}/"
      )
    .pipe gulp.dest "#{DIST}/"