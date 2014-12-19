gulp        = require 'gulp'
rename      = require 'gulp-rename'
sketch      = require 'gulp-sketch'
iconfont    = require 'gulp-iconfont'
consolidate = require 'gulp-consolidate'
zip         = require 'gulp-zip'
merge       = require 'merge-stream'
meta        = require '../package.json'

SRC      = './src'
DIST     = './dist'

# フォント生成
gulp.task 'icon', ->
  gulp.src "#{SRC}/map.sketch"
  .pipe sketch
    export: 'artboards'
    formats: 'svg'
  .pipe iconfont fontName: meta.name
  .on 'codepoints', (codepoints) ->
    options =
      glyphs: codepoints
      fontPath: './'
      meta: meta
    merge (
    	# フォントを利用するCSSファイルを生成
      gulp.src "#{SRC}/template/map.css"
      .pipe consolidate 'lodash', options
      .pipe rename basename: meta.name
      .pipe gulp.dest "#{DIST}/"
      # サンプルページの生成
      gulp.src "#{SRC}/template/index.html"
      .pipe consolidate 'lodash', options
      .pipe gulp.dest "./"
    )
  .pipe gulp.dest "#{DIST}/"
