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

        service.getGadm2codes = function (country){
            var deferred = $q.defer();

            var url =" http://54.200.155.189:3001/services/tables/site/query?where=adm0_name%20%3D%20'" + country + "'%20and%20adm2_code%20is%20not%20null&returnfields=adm2_code&format=geojson&returnGeometry=no&returnGeometryEnvelopes=no"

            // Cadasta API
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

        service.getGadm1codes = function (country){
            var deferred = $q.defer();

            var url = "http://54.200.155.189:3001/services/tables/district/query?where=adm0_name%20%3D%20'"  + country +"'%20and%20adm1_code%20is%20not%20null&returnfields=adm1_code&format=geojson&returnGeometry=no&returnGeometryEnvelopes=no"
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

