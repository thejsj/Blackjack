module.exports = function (grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    // CSS & Sass
    sass: {
      dist: {
        options: {
          outputStyle: 'expanded'
        },
        files: {
          'style.css': 'style.scss'
        }
      }
    },
    watch: {
      // grunt: {
      //   files: ['Gruntfile.js']
      // },
      sass: {
        files: 'style.scss',
        tasks: ['sass']
      },
      coffee: {
        files: ['src/**/*.coffee', 'spec/**/*.coffee'],
        tasks: ['coffee']
      },
      options: {
        livereload: true,
      },
    },
    coffee: {
      src: {
        expand: true,
        flatten: false,
        cwd: 'src',
        src: ['**/*.coffee'],
        dest: 'compiled/src',
        ext: '.js'
      },
      spec: {
        expand: true,
        flatten: false,
        cwd: 'spec',
        src: ['**/*.coffee'],
        dest: 'compiled/spec',
        ext: '.js'
      },
    },
    svgstore: {
      options: {
        prefix : 'shape-', // This will prefix each <g> ID
      },
      default : {
        files: {
          'img/all-cards.svg': ['img/cards/**/*.svg'],
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-svgstore');

  // Tasks
  grunt.registerTask('default', ['build']);
  grunt.registerTask('build', ['sass', 'coffee']);
};
