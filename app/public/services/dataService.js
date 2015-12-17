var app = angular.module("myApp")
    .service("dataService", ['$http', '$q', function ($http, $q, ENV) {

        var service = {};

        //service.albumSongHash = {};
        //service.all_songs = [];
        //
        //service.albumsGet = function () {
        //    var deferred = $q.defer();
        //
        //
        //    $http.get('api/all-albums', {cache: true}).
        //        then(function (response) {
        //            response.data.features.forEach(function (v) {
        //                v.properties.selected = false;
        //                service.albumSongHash[v.properties.title] = {};
        //                service.albumSongHash[v.properties.title].selected = false;
        //                service.albumSongHash[v.properties.title].songs = [];
        //            });
        //
        //            deferred.resolve(service.albumSongHash);
        //
        //        }, function (response) {
        //            deferred.reject(response);
        //        });
        //
        //    return deferred.promise;
        //
        //};
        //
        //service.songsGet = function () {
        //    var deferred = $q.defer();
        //
        //    $http.get('api/all-songs', {cache: true}).
        //        then(function (response) {
        //
        //            response.data.features.forEach(function (s) {
        //                var album = s.properties.album_title;
        //                var song = s.properties.song_title;
        //                service.all_songs.push(song);
        //                service.albumSongHash[album].songs.push({label:song, id: s.properties.id, selected:false});
        //
        //            });
        //
        //            deferred.resolve(service.all_songs);
        //
        //
        //
        //        }, function (response){
        //            deferred.reject(response);
        //        });
        //
        //    return deferred.promise;
        //
        //};
        //
        //service.songVotesGet = function () {
        //    var deferred = $q.defer();
        //
        //    $http.get('api/song-votes', {cache: false}).
        //        then(function (response) {
        //            deferred.resolve(response.data);
        //
        //        }, function (response){
        //            deferred.reject(response);
        //        });
        //
        //    return deferred.promise;
        //
        //};
        //
        //service.albumVotesGet = function () {
        //    var deferred = $q.defer();
        //
        //    $http.get('api/album-votes', {cache: true}).
        //        then(function (response) {
        //            deferred.resolve(response.data);
        //
        //        }, function (response){
        //            deferred.reject(response);
        //        });
        //
        //    return deferred.promise;
        //
        //};
        //
        //
        //service.vote = function (songId, roundId){
        //    var deferred = $q.defer();
        //
        //    var data = JSON.stringify({song:songId, round:roundId});
        //
        //    $http.post('api/all-songs',data, {headers: {'Content-type': 'application/json'}})
        //        .then(function (response) {
        //            deferred.resolve(response);
        //        }, function (response){
        //            deferred.reject(response);
        //        });
        //
        //    return deferred.promise;
        //}
        //
        return service;
    }]);

