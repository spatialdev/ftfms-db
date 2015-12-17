'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
    'ngRoute','ngMaterial', 'angularFileUpload'
]).
    config(['$routeProvider', function($routeProvider) {
        $routeProvider
            .when('/', {
                templateUrl: 'public/templates/home.html',
                controller: 'HomeCtrl'
            })

            .otherwise({
                redirectTo: '/'
            });

    }])
