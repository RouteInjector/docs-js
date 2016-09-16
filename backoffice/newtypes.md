# Add new types

## Files


## Schema definition
The first step is to define how we want to specify the new type. In this case for example we have choose type Number and format rating. Also we have defined two extra parameters like minValue and maxValue.

```javascript
difficulty: {type: Number, format: 'rating', minValue: 1, maxValue: 3}
```

## Template definition
Here we define the html template which will be loaded when our type is present in the schema. In this case we use a bootstrap directive <rating> with some parameters.

```html
<div class="form-group" ng-class="{'has-error': hasError()}">
    <label class="control-label" ng-show="showTitle()">{{form.title}}</label>
    <rating ng-model="$$value$$" max="form.maxValue" min="form.minValue" state-on="form.iconOn" state-off="form.iconOff"></rating>
</div>
```

## Add to schema form
The library which holds all the elements in the schena is called schemaForm, for this reason it is necessary to add our new element to this library.
The syntax is as follows:

```javascript
angular.module('schemaForm').config(
    ['schemaFormProvider', 'schemaFormDecoratorsProvider', 'sfPathProvider',
        function (schemaFormProvider, schemaFormDecoratorsProvider, sfPathProvider) {
            var mixed = function (name, schema, options) {
                //Check here the schema form
                if (schema.type === 'number' && (schema.format === 'rating')) {
                    var f = schemaFormProvider.stdFormObj(name, schema, options);
                    f.key = options.path;
                    f.type = 'rating';

                    //Collect the necessary information from the schema and store in the form object
                    if (schema.minValue)
                        f.minValue = schema.minValue;
                    if (schema.maxValue)
                        f.maxValue = schema.maxValue;
                    if (schema.iconOn)
                        f.iconOn = schema.iconOn;
                    if (schema.iconOff)
                        f.iconOff = schema.iconOff;

                    options.lookup[sfPathProvider.stringify(options.path)] = f;
                    return f;
                }
            };

            //Make schemaform trigger for each number
            schemaFormProvider.defaults.number.unshift(mixed);

            //Add to the bootstrap directive
            schemaFormDecoratorsProvider.addMapping(
                'bootstrapDecorator',
                'rating',
                'directives/decorators/bootstrap/rating/rating.html'
            );
            schemaFormDecoratorsProvider.createDirective(
                'rating',
                'directives/decorators/bootstrap/rating/rating.html'
            );
        }
    ]);
```

## Deploy with gulp and include
Finally we deploy to the library with a gulp task.

```javascript
/* global require */

var gulp = require('gulp');

var templateCache = require('gulp-angular-templatecache');
var minifyHtml = require('gulp-minify-html');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var streamqueue = require('streamqueue');
var jscs = require('gulp-jscs');
var plumber = require('gulp-plumber');

//Define minify task
gulp.task('minify', function() {
  var stream = streamqueue({objectMode: true});
  stream.queue(
              gulp.src('./src/*.html')
                  .pipe(minifyHtml({
                    empty: true,
                    spare: true,
                    quotes: true
                  }))
                  .pipe(templateCache({
                    module: 'schemaForm',
                    root: 'directives/decorators/bootstrap/rating/'
                  }))
    );
  stream.queue(gulp.src('./src/*.js'));

  stream.done()
        .pipe(concat('dist/bootstrap-rating.min.js'))
        .pipe(uglify())
        .pipe(gulp.dest('.'));

});

// Define non-minified-dist task
gulp.task('non-minified-dist', function() {
  var stream = streamqueue({objectMode: true});
  stream.queue(
              gulp.src('./src/*.html')
                  .pipe(templateCache({
                    module: 'schemaForm',
                    root: 'directives/decorators/bootstrap/rating/'
                  }))
    );
  stream.queue(gulp.src('./src/*.js'));

  stream.done()
        .pipe(concat('dist/bootstrap-rating.js'))
        .pipe(gulp.dest('.'));
});

//Define jscs task
gulp.task('jscs', function() {
  gulp.src('./src/**/*.js')
      .pipe(plumber())
      .pipe(jscs());
});

//Define task default
gulp.task('default', [
  'minify',
  'non-minified-dist',
  'jscs'
]);

//Trigger for each file in src, the task default
gulp.task('watch', function() {
  gulp.watch('./src/**/*', ['default']);
});
```




## Additionally trigger custom directive