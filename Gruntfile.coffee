"use strict"

module.exports = (grunt) ->
  grunt.initConfig
    imagemin:
      dist:
        options:
          optimizationLevel: 7
          progressive: true

        files: [
          expand: true
          cwd: "images/"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "images/"
         ]

    clean:
      dist: [ "assets/css/main.min.css", "assets/js/scripts.min.js" ]

  
  # Load tasks
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  
  # Register tasks
  grunt.registerTask "default", [ "imagemin" ]
  grunt.registerTask "dev", [ "watch" ]