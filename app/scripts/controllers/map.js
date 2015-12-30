/**
 * Created by Nicholas Hallahan <nhallahan@spatialdev.com>
 *     on Mon Mar 17 2014
 */

module.exports = angular.module('SpatialViewer').controller('MapCtrl', function ($scope, $rootScope, $state, $stateParams, LayerConfig, VectorProvider, MapDataService) {

    $rootScope.countryLayers = {
        "Ethiopia": "ethiopia_gaul_2014"
    }

    mapboxgl.accessToken = 'pk.eyJ1IjoiZGFuaWVsZHVoaCIsImEiOiJwaGJFeTlFIn0.yN6caVQJ2ZoqDIMMht_SVQ';

    var map = new mapboxgl.Map({
        container: 'map', // container id
        //style: 'mapbox://styles/mapbox/streets-v8', //stylesheet location
        center: [41.433007, 8.145159], // starting position
        zoom: 4 // starting zoom
    });

    //MapDataService.getGadm2codes('Ethiopia')
    //    .then(function(response){
    //      response.features.forEach(function(f){
    //        gadm2filter.push(["==", "adm2_code", f.properties.adm2_code])
    //      })
    //
    //    })
    //
    //
    //MapDataService.getGadm1codes('Ethiopia')
    //    .then(function(response){
    //      response.features.forEach(function(f){
    //        gadm1filter.push(["==", "adm1_code", f.properties.adm1_code])
    //      })
    //
    //    })


    // check if overLays in url have been drawn on map
    map.once('load', function () {

        var missingLayers = [];
        overlayNames.forEach(function (v, i) {
            var layer = LayerConfig[v];

            if (map.getLayer(layer.id) == undefined) {
                missingLayers.push(layer);
            }

        })

        // draw overlays
        if (missingLayers.length > 0) {
            drawOverlays();
        }

    })

    // check for new map style, if so, then reload layers
    map.on('style.load', function () {

            if (lastBasemapUrl !== null && lastBasemapUrl !== basemapUrl) {
                drawOverlays();
            }

            lastBasemapUrl = basemapUrl;

        }
    )

    map.on('click', function (e) {
        // Use featuresAt to get features within a given radius of the click event
        var layer = LayerConfig[overlayNames[0]].id;
        // Use layer option to avoid getting results from other layers
        map.featuresAt(e.point, {layer: layer, radius: 10, includeGeometry: true}, function (err, features) {
            if (err) throw err;
            // if there are features within the given radius of the click event,
            // fly to the location of the click event
            if (features.length) {
                // Get coordinates from the symbol and center the map on those coordinates
                //map.flyTo({center: features[0].geometry.coordinates});
                //console.log(features[0].properties.adm0_code + " " + features[1].properties.adm1_code);

                map.setFilter("route-click", ["==", "adm2_code", features[1].properties.adm2_code]);

                MapDataService.getDistricts(features[1].properties.adm1_code)
                    .then(function (response) {
                        $rootScope.$broadcast('details', response);
                    });
            }

        });
    });

    var lastLayersStr = '';
    var lastBasemapUrl = null;
    var basemapUrl;
    var basemapLayer = null;
    var layersStr = null;
    var overlays = [];
    var overlayNames = [];
    var theme = null;
    var filters = null;

    $scope.params = $stateParams;
    $scope.blur = '';

    $scope.toggleState = function (stateName) {
        var state = $state.current.name !== stateName ? stateName : 'main';
        $state.go(state, $stateParams);
    };
    //

    function redraw() {
        var lat = parseFloat($stateParams.lat) || 0;
        var lng = parseFloat($stateParams.lng) || 0;
        var zoom = parseFloat($stateParams.zoom) || 8;
        layersStr = $stateParams.layers || LayerConfig.osm.url;
        var layers = layersStr.split(',');

        // first layer should always be treated as the basemap
        var basemap = LayerConfig.find(layers[0]) || LayerConfig.osm.url;
        if (typeof basemap === 'string') {
            basemapUrl = basemap;
        } else {
            basemapUrl = basemap.url;
        }
        overlayNames = layers.slice(1);

        if (lastBasemapUrl !== basemapUrl && typeof map === 'object') {
            if (basemapLayer) {
                //map.removeLayer(basemapLayer);
            }
            // draw gl map

            basemapLayer = map.setStyle(basemapUrl);

            //map.fire('newStyle', {"lastBasemapUrl":lastBasemapUrl, "basemapUrl":basemapUrl});

        }

        if (lastLayersStr !== layersStr) {
            if (map.loaded() == true) {
                drawOverlays();
            }
        }

        if (theme != $stateParams.theme || filters != $stateParams.filters) { // null and undefined should be ==
            theme = $stateParams.theme;
            filters = $stateParams.filters;
        }

        var c = $scope.center = {
            lat: lat,
            lng: lng,
            zoom: zoom
        };

        if (typeof map === 'object' && (c.lat != 0 && c.lng != 0)) {
            //map.setView([c.lat, c.lng], zoom);
        }

        lastLayersStr = layersStr;
    }

    //
    //
    /***
     * Broadcast Listeners.
     */
    $scope.$on('route-update', function () {
        if ($scope.blur === 'blur' && $state.current.name !== 'landing') {
            $scope.blur = '';
        }

        var c;
        if (!$scope.center) {
            var lat = parseFloat($stateParams.lat) || 0;
            var lng = parseFloat($stateParams.lng) || 0;
            var zoom = parseFloat($stateParams.zoom) || 8;

            c = $scope.center = {
                lat: lat,
                lng: lng,
                zoom: zoom
            };
        }
        else {
            c = $scope.center;
        }


        var lat = c.lat.toFixed(6);
        var lng = c.lng.toFixed(6);
        var zoom = c.zoom.toString();
        if (mapMoveEnd) {
            mapMoveEnd = false;
        } else if ($stateParams.lat !== lat
            || $stateParams.lng !== lng
            || $stateParams.zoom !== zoom
            || $stateParams.layers !== layersStr
            || $stateParams.theme !== theme
            || $stateParams.filters !== filters) {

            console.log('map.js route-update Updating Map...');
            if (map.loaded() == true) {
                redraw();
            }
        }

    });
    //
    //$scope.$on('blur', function() {
    //  $scope.blur = 'blur';
    //});
    //
    ////this takes in a WKT GeoJSON Extent geometry
    //$scope.zoomToExtent = function(extent) {
    //  delete $stateParams['zoom-extent'];
    //  map.fitBounds([
    //    [extent[0][1], extent[0][0]],
    //    [extent[2][1], extent[2][0]]
    //  ]);
    //};
    //
    ////This take a leaflet bounds object and handles it.
    //delete $stateParams['zoom-extent'];
    //$scope.zoomToBounds = function(bounds) {
    //  map.fitBounds(bounds);
    //};
    //
    //
    //window.map = map;
    map.on('move', function () { // move is good too
        var c = map.getCenter();
        var lat = c.lat.toFixed(6);
        var lng = c.lng.toFixed(6);
        var zoom = map.getZoom().toString();

        if ($stateParams.lat !== lat
            || $stateParams.lng !== lng
            || $stateParams.zoom !== zoom) {

            console.log('map: lat,lng,zoom !== $stateParams');
            $stateParams.lat = lat;
            $stateParams.lng = lng;
            $stateParams.zoom = zoom;
            mapMoveEnd = true;
            $state.go($state.current.name, $stateParams);
        }
    });
    //
    ////Connect the layout onresize end event
    //try {
    //  window.layout.panes.center.bind("layoutpaneonresize_end", function() {
    //    map.invalidateSize();
    //  });
    //} catch (e) {
    //  //Nothing
    //}
    //
    //

    /**
     * Listen for theme change
     *
     */
    $scope.$on('themes-update', function (e, data) {
        var theme = $stateParams.theme;
        var batchLayoutProperties = [];
        var batchaddLayer = [];
        var batchhideLayer = [];

        //var overLay = LayerConfig[overlayNames];

        overlayNames.forEach(function (val) {
            var overLay = LayerConfig[val];
            // get layer based on theme
            if (overLay !== undefined) {
                var layer = getLayer(overLay, theme);

                if (map.loaded() && overLay.active == true) {
                    // set layer to visible if already a part of map
                    if (map.getLayer(layer.id) !== undefined) {
                        batchLayoutProperties.push(layer.id);
                    } else {
                        /// add layer
                        batchaddLayer.push(layer);
                    }

                    // hide other gadm layers
                    //hideLayers(overLay, theme)
                }
            }
        })

        if (batchaddLayer.length > 0 || batchLayoutProperties.length > 0) {
            map.batch(function (batch) {
                batchaddLayer.forEach(function (val) {
                    batch.addLayer(val);
                })
                batchLayoutProperties.forEach(function (val) {
                    batch.setLayoutProperty(val, "visibility", "visible");
                })

                overlayNames.forEach(function (val) {
                    LayerConfig[val].layers.forEach(function (v) {
                        if (v["source-layer"] !== theme && map.getLayer(v.id) !== undefined) {
                            batch.setLayoutProperty(v.id, "visibility", "none")
                        }
                    })
                })



            })
        }
    })

    /**
     *
     * @param source - Vector Source Layer Object
     * @param theme - gadm level
     * @returns {*} - layer object
     */
    function getLayer(source, theme) {
        var layers = source.layers;
        var layer;

        layers.forEach(function (val, i) {
            if (val["source-layer"] == theme) {
                layer = layers[i];
            }
        })

        return layer;
    }

    /**
     * Hide all layers except current theme
     *
     * @param source - Vector Source Layer Object
     * @param theme - gadm level
     *
     */
    function hideLayers(overLays, theme) {

        if(map.loaded()) {

            map.batch(function (batch) {

                overLays.forEach(function (val) {
                    LayerConfig[val].layers.forEach(function (v) {
                        if (v["source-layer"] !== theme && map.getLayer(v.id) !== undefined) {
                            batch.setLayoutProperty(v.id, "visibility", "none")
                        }
                    })
                })
            })
        }
    }

    function drawOverlays() {
        var theme = $stateParams.theme;

        for (var i = 0, len = overlayNames.length; i < len; ++i) {
            var overlayName = overlayNames[i];
            var currOverlay = overlays[i];
            var cfg = LayerConfig[overlayName];
            var layer = getLayer(cfg, theme);


            if (map.getLayer(LayerConfig[overlayName].id) !== undefined && currOverlay && currOverlay.overlayName === overlayName) {
                continue; // layer is already there, continue on!
            }

            // remove the current layer that is not what should be that layer in the list
            else if (currOverlay && currOverlay._map) {
                if (currOverlay.destroyResource) currOverlay.destroyResource();
                map.removeLayer(currOverlay);
            }

            if (typeof LayerConfig[overlayName] === 'object'
                && LayerConfig[overlayName]["layer-type"].toLowerCase() === 'vector') {


                // make sure make is finished loading

                // check to see if source exists
                if (map.getSource(cfg.source) == undefined) {

                    map.addSource(cfg.source, {
                        type: cfg["layer-type"],
                        tiles: [cfg.url]
                    });

                }

                if (map.getLayer(layer.id) == undefined) {
                    map.addLayer(layer);
                }
                //layer.addTo(map);

                //map.on('load', function(e){
                //
                //  layer = map.addSource(cfg.source, {
                //    type: cfg["layer-type"],
                //    tiles: [cfg.url]
                //  });
                //
                //  var tempcfg = LayerConfig[overlayName];
                //
                //  for (var key in tempcfg.style){
                //    tempcfg[key] = cfg.style[key];
                //  }
                //
                //  delete tempcfg.style;
                //
                //  map.addLayer (tempcfg);
                //})

                //map.on('click', function (e) {
                //    //Take the click event and pass it to the group layers.
                //    pbfSource.onClick(e, function (evt) {
                //        if (evt && evt.feature) {
                //            console.log(['Clicked PBF Feature', evt.feature.properties]);
                //        }
                //    });
                //});
                //
                //map.on('layerremove', function (removed) {
                //    //This is the layer that was removed.
                //    //If it is a TileLayer.PBFSource, then call a method to actually remove the children, too.
                //    if (removed.layer.removeChildLayers) {
                //        removed.layer.removeChildLayers(map);
                //    }
                //});

            }

            // try for WMS (not a vector layer)
            // if things get more fancy with wms, it should get its own factory
            else if (typeof LayerConfig[overlayName] === 'object'
                && LayerConfig[overlayName].type.toLowerCase() === 'wms') {

                //var cfg = LayerConfig[overlayName];
                //var layer = L.tileLayer.wms(cfg.url, {
                //    format: cfg.format || 'image/png',
                //    transparent: cfg.transparent || true,
                //    layers: cfg.layers
                //});
                //layer.addTo(map);
            }

            /**
             * Tiles that are an overlay. OSM / Google / Mapnik tend to make tiles in this format.
             */
            else if (typeof LayerConfig[overlayName] === 'object'
                && LayerConfig[overlayName].type.toLowerCase() === 'xyz') {
                //
                //var cfg = LayerConfig[overlayName];
                //var layer = L.tileLayer(cfg.url, {
                //    opacity: cfg.opacity || 0.5
                //});
                //layer.addTo(map);
            }

            /**
             * TMS flips the y. GeoServer often serves this.
             */
            else if (typeof LayerConfig[overlayName] === 'object'
                && LayerConfig[overlayName].type.toLowerCase() === 'tms') {
                //var cfg = LayerConfig[overlayName];
                //var layer = L.tileLayer(cfg.url, {
                //    opacity: cfg.opacity || 0.5,
                //    tms: true
                //});
                //layer.addTo(map);
            }

            // if its not wms, its a vector layer
            else {
                //var vecRes = VectorProvider.createResource(overlayName);
                //var layer = vecRes.getLayer();
                //layer.addTo(map);
            }

            cfg.overlayName = overlayName;
            overlays[i] = cfg;

        }

        //TODO clean this up so it removes the correct overlay

        // there are more overlays left in the list, less layers specified in route
        // we need to remove those too.
        for (var len2 = overlays.length; i < len2; ++i) {
            //if (overlays[i].destroyResource) overlays[i].destroyResource();

            var layer = getLayer(overlays[i], theme);

            map.removeLayer(layer.id);
            delete overlays[i];
        }

    }

});