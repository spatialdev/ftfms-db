module.exports = function(grunt) {


    grunt.registerTask('updateDocs', ['static_api_docs']);



    grunt.initConfig({

        /* These are the configs for the docs taskrunner
         *
         */
        static_api_docs: {
            api_docs: {
                src: "app/api/documentation.json",
                dest: "app/api"
            }
        }

        /* These are the configs for the watch taskrunner
         * run concat whenever js changes
         */
        //watch: {
        //    js: {
        //        files: ['js/**/*.js'],
        //        tasks: ['concat:js', 'uglify:js']
        //    },
        //    css: {
        //        files: ['css/**/*.css'],
        //        tasks: ['concat:css']
        //    },
        //},
    });



    //grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('static-api-docs');
}