var app = angular.module("SpatialViewer")
    .service("MapDataService", ['$http', '$q', function ($http, $q) {

        var service =  {};

        service.getCountries = function(){

            var deferred = $q.defer();

            // Cadasta API
            $http.get('http://localhost:4000/api/Countries/', { cache: true })
                .then(function(response) {
                    if(response.data && response.data.error) {
                        deferred.reject(response.data.error);
                    }
                    deferred.resolve(response.data);
                }, function(err) {
                    deferred.reject(err);
                });

            // CKAN API for project description
            return deferred.promise;
        };

        service.getGadmCodes = function (country, level, table){
            var deferred = $q.defer();
            var nameColumn = (level == 'adm0_code') ? 'title' : 'adm0_name';

            var url = "http://54.200.155.189:3001/services/tables/" + table + "/query?where=" + nameColumn + "%20%3D%20'"  + country +"'%20and%20" + level + "%20is%20not%20null&returnfields=" +  level +  "&format=geojson&returnGeometry=no&returnGeometryEnvelopes=no"
            $http.get(url, { cache: true })
                .then(function(response) {
                    if(response.data && response.data.error) {
                        deferred.reject(response.data.error);
                    }
                    deferred.resolve(response.data);
                }, function(err) {
                    deferred.reject(err);
                });

            // CKAN API for project description
            return deferred.promise;
        }


        return service;
    }])

