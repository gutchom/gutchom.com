gulp = require 'gulp'
jade = require 'gulp-jade'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'

plumber = require 'gulp-plumber'
webserver = require 'gulp-webserver'

csscomb = require 'gulp-csscomb'
cssmin = require 'gulp-cssmin'
pleeease = require 'gulp-pleeease'
sourcemaps = require 'gulp-sourcemaps'
coffeelint = require 'gulp-coffeelint'


COPY_FILES = './assets/**/*'
SRC_JADE = './src/jade/**/*.jade'
SRC_SASS = './src/sass/**/*.sass'
SRC_COFFEE = './src/coffee/**/*.coffee'

gulp.task 'default', [
  'copy'
  'jade'
  'sass'
  'pleeease'
  'coffee'
  'webserver'
  'watch'
]
gulp.task 'test', []
gulp.task 'build', []

gulp.task 'copy', ->
  gulp
    .src COPY_FILES
    .pipe plumber()
    .pipe gulp.dest 'dest'

gulp.task 'jade', ->
  gulp
    .src SRC_JADE
    .pipe plumber()
    .pipe jade()
    .pipe gulp.dest 'dest'

gulp.task 'sass', ->
  gulp
    .src SRC_SASS
    .pipe changed('dest')
    .pipe plumber()
    .pipe csscomb()
    .pipe sourcemaps.init()
      .pipe sass(
        style: 'expanded'
      )
    .pipe sourcemaps.write('./maps')
    .pipe gulp.dest 'dest'

gulp.task 'pleeease', ->
  gulp
    .src SRC_SASS
    .pipe pleese(
      fallbacks:
        autoprefixer: ['last 4 versions']
      optimizers:
        minifire: false
    )
    .pipe gulp.dest 'dest'

gulp.task 'coffee', ->
  gulp
    .src SRC_COFFEE
    .pipe changed('dest')
    .pipe
    .pipe plumber()
    .pipe coffee()
    .pipe gulp.dest 'dest'

gulp.task 'webserver', ->
  gulp
    .src 'dest'
    .pipe webserver
      livereload: true

gulp.task 'watch', ->
  gulp.watch COPY_FILES, ['copy']
  gulp.watch SRC_JADE, ['jade']
  gulp.watch SRC_SASS, ['sass']
  gulp.watch SRC_COFFEE, ['coffee']
