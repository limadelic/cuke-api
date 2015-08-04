module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    watch:
      src:
        files: ['src/**/*.coffee']
        tasks: ['coffee']
      tdd:
        files: [
          'src/**/*.coffee'
          'test/**/*.coffee'
        ]
        tasks: ['shell:mocha']

    coffee:
      src:
        expand: true
        options:
          bare: true
        cwd: 'src'
        src: ['**/*.coffee']
        dest: 'lib'
        ext: '.js'

    shell:
      mocha:
        command: 'mocha'

  require('load-grunt-tasks') grunt

  grunt.option 'force', true

  grunt.registerTask 'default', ['coffee', 'watch:src']
  grunt.registerTask 'tdd', ['shell:mocha', 'watch:tdd']
