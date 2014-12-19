gulp        = require 'gulp'
runSequence = require 'run-sequence'
bower       = require 'bower'
consolidate = require 'gulp-consolidate'
zip         = require 'gulp-zip'
meta        = require '../package.json'

SRC      = './src'
DIST     = './dist'

gulp.task 'build', (cb) -> runSequence ['build-zip', 'build-bower'], cb

# ダウンロード用のZipファイル生成
gulp.task 'build-zip', ->
	gulp.src ["#{DIST}/*", "!#{DIST}/*.zip"]
	.pipe zip "#{meta.name}.zip"
	.pipe gulp.dest "#{DIST}/"
	
# bower.jsonの更新
gulp.task 'build-bower', ->
  gulp.src "#{SRC}/template/bower.json"
  .pipe consolidate 'lodash', meta: meta
  .pipe gulp.dest './'
