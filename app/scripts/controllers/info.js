/**
 * Created by Nicholas Hallahan <nhallahan@spatialdev.com>
 *       on 3/27/14.
 */

module.exports = angular.module('SpatialViewer').controller('InfoCtrl', function($scope) {
  $scope.params = $stateParams;
});