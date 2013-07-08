module.exports = (grunt) ->

  grunt.initConfig
    
    jasmine:
      default:
        src: 'test/code.js'
        options:
          specs: 'test/specs.js'
          helpers: 'test/helpers.js'
    
    copy:
      default:
        options:
          processContentExclude: [
            '**/*.{png,gif,jpg,ico}'
          ]
        files: [
            expand: true
            cwd: 'src/chrome/'
            src: ['manifest.json']
            dest: 'build/chrome/'
          ,
            expand: true
            cwd: 'src/images/'
            src: ['icon128.png', 'icon48.png', 'icon16.png']
            dest: 'build/chrome/images/'
        ]
    
    coffee:
      default:
        options:
          bare: true
        files:
          'build/chrome/js/contentscript.js' : ['src/contentscript.coffee']
      test:
        options:
          bare: true
        files:
          'test/code.js' : ['src/contentscript.coffee']
      testSpecs:
        options:
          bare: true
        files:
          'test/specs.js' : ['src/**/*.spec.coffee']
      testHelpers:
        options:
          bare: true
        files:
          'test/helpers.js' : ['src/**/*.helper.coffee']
    
    watch:
      default:
        files: ['src/chrome/manifest.json', 'src/images/**', 'src/**/*.coffee']
        tasks: ['copy:default', 'coffee:default']
      test:
        files: ['src/**/*.coffee']
        tasks: ['coffee:test', 'coffee:testSpecs', 'coffee:testHelpers', 'jasmine:default']

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  
  grunt.registerTask 'default', ['copy:default', 'coffee:default', 'watch:default']
  grunt.registerTask 'test', ['coffee:test', 'coffee:testSpecs', 'coffee:testHelpers', 'watch:test']
