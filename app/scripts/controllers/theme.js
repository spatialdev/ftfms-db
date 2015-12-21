/**
 * Created by Nicholas Hallahan <nhallahan@spatialdev.com>
 *       on 5/6/14.
 */

module.exports = angular.module('SpatialViewer').controller('ThemeCtrl', function ($scope, $rootScope, $state, $stateParams, VectorProvider) {

  var themeNameHash = $rootScope.themeNameHash = {
    all: 'All Countries',
    bangladesh: 'Bangladesh',
    india: 'India',
    indonesia: 'Indonesia',
    kenya: 'Kenya',
    nigeria: 'Nigeria',
    tanzania: 'Tanzania',
    uganda: 'Uganda'
  };

  $scope.setTheme = function(key) {
    $scope.themeName = themeNameHash[key];
    $scope.setThemeQueryParam(key);
  };

  $scope.setThemeQueryParam = function (theme) {
    $stateParams.theme = theme;
    var state = $state.current.name || 'main';
    $state.go(state, $stateParams);
  };

  $scope.themeName = themeNameHash[$stateParams.theme] || 'All Countries';

  /*
   Handling Theme Menu Animations
   */

  $scope.toggleThemeMenu = function(){
    var flippedOut = $(".menu-selection .dropdown").hasClass("open");

    if(flippedOut == false){
      $scope.unfurlThemes();
    }
    else{
      $scope.refurlThemes();
    }
  };

  $scope.unfurlThemes = function(){
    $scope.refurlThemes();
    //Try jQuery to add an 'on' class to each of the theme LI elements on a timer.
    $($('#ThemeMenu li').get().reverse()).each(function(index){
      var self = this;
      setTimeout(function () {
        $(self).addClass("theme-selector-li-on");
      }, index*150);
    });
  };

  //Refurl?
  $scope.refurlThemes = function(){
    //Try jQuery to remove the 'on' class to each of the theme LI elements on a timer.
    $('#ThemeSelectorMenu .dropdown-menu li').removeClass("theme-selector-li-on");
  };

  /*
   End Theme Menu Animations
   */

});