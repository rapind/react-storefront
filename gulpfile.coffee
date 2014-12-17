gulp = require 'gulp'
del = require 'del'

# Load plugins
$ = require('gulp-load-plugins')()
source = require 'vinyl-source-stream'

# Bower
gulp.task('bower', ->
  gulp.src('bower_components/**/*.js', {base: 'bower_components'})
    .pipe(gulp.dest('dist/bower_components/'))
)

# Views
gulp.task('views', ->
  return gulp.src('app/views/*.jade')
    .pipe($.jade({ pretty: true }))
    .pipe(gulp.dest('dist'))
)

# Styles
gulp.task('styles', ->
  gulp.src('app/styles/application.sass')
    .pipe($.rubySass(
      style: 'expanded',
      precision: 10,
      loadPath: ['bower_components']
    ))
    .pipe($.autoprefixer('last 1 version'))
    .pipe(gulp.dest('dist/styles'))
    .pipe($.size())
)

# Scripts
gulp.task 'scripts', ->
  gulp.src('app/scripts/application.coffee', { read: false })
    .pipe($.browserify({
        transform: ['coffee-reactify'],
        extensions: ['.coffee'],
    }))
    .pipe($.rename('application.js'))
    .pipe(gulp.dest('dist/scripts'))

# Images
gulp.task('images', ->
  return gulp.src('app/images/**/*')
    .pipe($.cache($.imagemin(
      optimizationLevel: 3,
      progressive: true,
      interlaced: true
    )))
    .pipe(gulp.dest('dist/images'))
    .pipe($.size())
)

# JSON
gulp.task('json', ->
  gulp.src('app/data/**/*.json', {base: 'app/data'})
    .pipe(gulp.dest('dist/data/'))
)

# Build
gulp.task('build', ['bower', 'views', 'styles', 'scripts', 'images', 'json'])

# Clean
gulp.task('clean', (cb) ->
  del(['dist/styles', 'dist/scripts', 'dist/images'], cb)
)

# Default task
gulp.task('default', ['watch'])

# Webserver
gulp.task('serve', ->
  gulp.src('dist')
    .pipe($.webserver({
      livereload: true,
      port: 3000
    }))
)

# Watch
gulp.task('watch', ['build', 'serve'], ->
  gulp.watch('app/views/**/*', ['views'])
  gulp.watch('app/styles/**/*', ['styles'])
  gulp.watch('app/scripts/**/*', ['scripts'])
  gulp.watch('app/images/**/*', ['images'])
  gulp.watch('app/data/**/*', ['json'])
)
