gulp        = require 'gulp'
del         = require 'del'
runSequence = require 'run-sequence'
requireDir  = require 'require-dir'
dir         = requireDir './task'

# デフォルト: `$ gulp` で呼ばれる
gulp.task 'default', (cb) -> runSequence 'clean', 'icon', 'build', cb

# 自動生成されるファイル/ディレクトリの削除
gulp.task 'clean', (cb) ->
  del [
    './dist'
    './asset'
    './bower.json'
    './index.html'
  ], -> cb()

# 監視
gulp.task 'watch', ->
  o = debounceDelay: 10000
  gulp.watch [
    'src/*.html'
    'src/*.css'
    'src/map.sketch/Data'
  ], o, ['icon']
