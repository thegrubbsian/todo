var gulp = require("gulp");
var concat = require("gulp-concat");
var filter = require("gulp-filter");
var react = require("gulp-react");
var sass = require("gulp-sass");
var uglify = require("gulp-uglify");
var watch = require("gulp-watch");

function env() { return process.env.GULP_ENV || "development"; }

var paths = {
  scripts: [
    "bower_components/jquery/dist/jquery.js",
    "bower_components/underscore/underscore.js",
    "bower_components/backbone/backbone.js",
    "bower_components/react/react-with-addons.js",
    "priv/static/js/backbone_react_mixin.js",
    "priv/static/js/phoenix.js",
    "priv/static/js/todo.js",
    "priv/static/js/todos.js",
    "priv/static/js/live_updater.js",
    "priv/static/js/todo_item.jsx",
    "priv/static/js/footer.jsx",
    "priv/static/js/app.jsx"
  ],
  styles: [
    "bower_components/todomvc-common/base.css",
    "priv/static/css/**/*.scss"
  ],
  images: ["priv/static/images/**/*"]
};

gulp.task("scripts", function() {
  return gulp.src(paths.scripts)
    .pipe(react())
    .pipe(concat("app.js"))
    .pipe(gulp.dest("priv/static/assets"));
});

gulp.task("styles", function() {
  return gulp.src(paths.styles)
    .pipe(sass())
    .pipe(concat("app.css"))
    .pipe(gulp.dest("priv/static/assets"));
});

gulp.task("images", function() {
  return gulp.src(paths.images)
    .pipe(gulp.dest("priv/static/assets"));
});

gulp.task("set-prod-build", function() {
  process.env["GULP_ENV"] = "production";
});

gulp.task("build", ["scripts", "styles", "images"]);

gulp.task("build-prod", ["set-prod-build", "build"]);

gulp.task("watch", function() {
  watch({ glob: "priv/static/css/**/*.*css", name: "Styles" }, ["styles"]);
  watch({ glob: "priv/static/js/**/*.j*", name: "Scripts" }, ["scripts"]);
  watch({ glob: "priv/static/images/**/*", name: "Images" }, ["images"]);
});

gulp.task("default", ["watch"]);
