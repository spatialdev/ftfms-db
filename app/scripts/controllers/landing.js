module.exports = angular.module('SpatialViewer').controller('LandingCtrl', function($scope, $rootScope, $stateParams) {
  console.log('LandingCtrl');
  $scope.params = $stateParams;

  $rootScope.$broadcast('blur');

});
