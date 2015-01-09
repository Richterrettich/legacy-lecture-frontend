/**
 * Created by Rene on 09.01.2015.
 */
module.exports = function (grunt) {
    grunt.loadNpmTasks('grunt-ngdocs');
    grunt.initConfig({
        ngdocs: {
            options: {
                html5Mode: true
            },
            all: ['webclient/app/users/**/*.js']
        },
        connect: {
            options: {
                keepalive: true
            },
            server: {}
        },
        clean: ['docs']
    });
    grunt.registerTask('default', ['ngdocs']);
};