angular.module('myApp')

    .controller('HomeCtrl', function ($scope,$http,$rootScope,dataService) {

        $scope.title = 'Sample Angular Node App!!';


        /*
         * broadcast
         */
        //$scope.$on('data-change',function(evt,data){
        //    console.log(data);
        //});

        /*
         * http request with promise
         */
        //var promise = dataService.albumsGet();
        //
        //promise.then(function(response){
        //    $scope.albumSongHash = response.albumSongHash;
        //
        //    return dataService.songsGet();
        //
        //}).then(function(response){
        //    $scope.all_songs = response.all_songs;
        //});
    });