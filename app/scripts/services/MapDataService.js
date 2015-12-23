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

        service.getDistricts = function(id){

            var deferred = $q.defer();

            // Cadasta API
            $http.get('http://localhost:4000/api/district_summary_data/' + id, { cache: true })
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

        return service;
    }])

