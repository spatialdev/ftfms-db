/**
 * This is the entry point of the application. We declare the main module here and then configure the main router
 * that creates corresponding views. The array parameter for module declares this module's dependencies.
 */
var SpatialViewer = angular.module('SpatialViewer', ['angularFileUpload', 'ngCookies', 'ngResource', 'ngSanitize', 'ui.router', 'ngAnimate', 'ui.bootstrap', 'ui.slider']);

SpatialViewer.run(function ($rootScope, $state, $stateParams) {

  // It's very handy to add references to $state and $stateParams to the $rootScope
  // so that you can access them from any scope within your applications.For example,
  // <li ui-sref-active="active }"> will set the <li> // to active whenever
  // 'contacts.list' or one of its decendents is active.
  $rootScope.$state = $state;
  $rootScope.$stateParams = $stateParams;

  debug.$state = $state;
  debug.$stateParams = $stateParams;

  $rootScope.isState = function (stateName) {
    return $state.$current.name === stateName;
  };

  $rootScope.isParam = function(paramName) {
    var bool = $stateParams[paramName];
    if (!bool) {
      return false;
    }
    return true;
  };

  $rootScope.isNotParam = function(paramName) {
    var bool = $stateParams[paramName];
    if (!bool) {
      return true;
    }
    return false;
  };

  $rootScope.toggleParam = function(paramName) {
    var bool = $stateParams[paramName];
    if (!bool) {
      // mutex logic that makes only 1 panel open at a time
      for (var param in $stateParams) {
        if ($stateParams[param] === 'open') {
          $stateParams[param] = null;
        }
      }
      $stateParams[paramName] = 'open';
    } else {
      delete $stateParams[paramName];
    }
    var state = $state.current.name || 'main';
    $state.go(state, $stateParams);
  };

  $rootScope.setParamWithVal = function (paramName, val) {
    $stateParams[paramName] = val;
    var state = $state.current.name || 'main';
    $state.go(state, $stateParams);
  };
  debug.$rootScope = $rootScope;


  $rootScope.openParam = function(paramName) {
    var bool = $stateParams[paramName];
    if (!bool) {
      // mutex logic that makes only 1 panel open at a time
      for (var param in $stateParams) {
        if ($stateParams[param] === 'open') {
          $stateParams[param] = null;
        }
      }
      $stateParams[paramName] = 'open';
      var state = $state.current.name || 'main';
      $state.go(state, $stateParams);
    }
  };

  $rootScope.closeParam = function(paramName) {
    var bool = $stateParams[paramName];
    if (bool) {
      delete $stateParams[paramName];
      var state = $state.current.name || 'main';
      $state.go(state, $stateParams);
    }
  };

  $rootScope.isNotState = function (stateName) {
    return $state.$current.name !== stateName;
  };

  window.$state = $state;
  window.$stateParams = $stateParams;

});

SpatialViewer.config(function ($stateProvider, $urlRouterProvider) {
  $urlRouterProvider
      .when('/default', '/map@0,0,2(satellite,wa),Ethiopia')
      .when('/phl', '/map@11.759815,121.893311,6(satellite,phl),Ethiopia')
      .otherwise(localStorage.getItem('defaultRoute') || '/map@0,0,2(satellite),Ethiopia');

  $stateProvider
      .state('main', {
        url: '/map@:lat,:lng,:zoom(*layers),:country?title&zoom-extent&stories&layers-panel&filters-panel&filters&legend&basemaps&info&theme&details-panel&search-panel&sf_id&level',
        views: {
          'details': {
            template: ' ',
            controller: 'MainCtrl'
          },
          'theme': {
            templateUrl: 'views/theme.html',
            controller: 'ThemeCtrl'
          }
        }
      })
      .state('upload', {
        url: '/map@:lat,:lng,:zoom(*layers),:country/upload?title&zoom-extent&stories&layers-panel&filters-panel&filters&legend&basemaps&info&theme&details-panel&search-panel&sf_id&level',
        views: {
          'details': {
            template: ' ',
            controller: 'MainCtrl'
          },
          'upload': {
            templateUrl: 'views/upload.html',
            controller: 'UploadCtrl'
          }
        }
      })
      .state('export', {
        url: '/map@:lat,:lng,:zoom(*layers),:country/export?title&zoom-extent&stories&layers-panel&filters-panel&filters&legend&basemaps&info&theme&details-panel&search-panel&sf_id&level',
        views: {
          'details': {
            template: ' ',
            controller: 'MainCtrl'
          },
          'export': {
            templateUrl: 'views/export.html',
            controller: 'ExportCtrl'
          }
        }
      });

});


SpatialViewer.directive('selectOnClick', function () {
  return {
    restrict: 'A',
    link: function (scope, element, attrs) {
      element.on('click', function () {
        this.select();
      });
    }
  };
});


angular.module('SpatialViewer').directive('myShow', function($animate) {
  return {
    scope: {
      'myShow': '=',
      'afterShow': '&',
      'afterHide': '&'
    },
    link: function(scope, element) {
      scope.$watch('myShow', function(show, oldShow) {
        if (show) {
          $animate.removeClass(element, 'ng-hide', scope.afterShow);
        }
        if (!show) {
          $animate.addClass(element, 'ng-hide', scope.afterHide);
        }
      });
    }
  }
});


require('./services/LayerConfig');
require('./services/StoriesConfig');
require('./services/Vector/VectorProvider');
require('./services/Donuts');
require('./services/MapDataService')
require('./controllers/main');
require('./controllers/map');
require('./controllers/details');
require('./controllers/navbar');
require('./controllers/side-view');
require('./controllers/stories');
require('./controllers/layers');
require('./controllers/filters');
require('./controllers/legend');
require('./controllers/info');
require('./controllers/basemaps');
require('./controllers/breadcrumbs');
require('./controllers/zoom-extent');
require('./controllers/theme');
require('./controllers/upload');
require('./controllers/search');
require('./controllers/export');
require('../lib/Leaflet.PBFLayer/src/PBFSource.js');
