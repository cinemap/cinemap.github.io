
config =

    connect:
        options:
            hostname: '0.0.0.0'
            port: 1111
            keepalive: true
            livereload: true
            open: true

    clean: ['build/**/*']

    coffee:
        main:
            src: 'src/scripts/*.coffee'
            dest: 'src/temp/coffee.js'

    stylus:
        main:
            src: 'src/styles/style.styl'
            dest: 'src/temp/stylus.css'

    cssmin:
        main:
            src: "styles.css"
            dest: "styles.css"

    jade:
        main:
            files: [
                expand: true
                cwd: 'src/pages/'
                src: '*.jade'
                dest: ''
                ext: '.html'
            ]

    concat:
        css:
            src: ['src/styles/*.css', 'src/temp/stylus.css']
            dest: 'styles.css'
        js:
            src: ['src/scripts/*.js', 'src/temp/coffee.js']
            dest: 'scripts.js'

    uglify:
        main:
            src: 'scripts.js'
            dest: 'scripts.js'

    copy:
        html:
            files: [
                expand: true
                cwd: 'src/pages/'
                src: '*.html'
                dest: 'build/'
            ]

    watch:
        options:
            livereload: true
        stylus:
            files: ['src/styles/*.styl']
            tasks: ['stylus', 'concat:css']
        css:
            files: ['src/styles/*.css']
            tasks: ['concat:css']
        coffee:
            files: 'src/scripts/*.coffee'
            tasks: ['coffee', 'concat:js']
        js:
            files: ['src/scripts/*.js']
            tasks: ['concat:js']
        jade:
            files: 'src/pages/*.jade'
            tasks: 'jade'

module.exports = (grunt) ->

    require('time-grunt') grunt
    grunt.initConfig(config)
    require('jit-grunt') grunt

    grunt.registerTask 'build', ['copy', 'jade', 'stylus', 'concat:css', 'coffee', 'concat:js']
    grunt.registerTask 'polish', ['clean', 'build', 'cssmin', 'uglify']

