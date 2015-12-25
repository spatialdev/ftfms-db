/**
 * Created by Nicholas Hallahan <nhallahan@spatialdev.com>
 *     on Mon Mar 17 2014
 */

module.exports = angular.module('SpatialViewer').controller('MapCtrl', function($scope, $rootScope, $state, $stateParams, LayerConfig, VectorProvider, MapDataService) {
  //var map = L.map('map');

  var mapLoaded = false;

  var gadm2filter = ["any"];
  var gadm2layer;

  var gadm1filter = ["any"];
  var gadm1layer;

  mapboxgl.accessToken = 'pk.eyJ1IjoiZGFuaWVsZHVoaCIsImEiOiJwaGJFeTlFIn0.yN6caVQJ2ZoqDIMMht_SVQ';

  //MapDataService.getCountries()
  //    .then(function(response){
  //      console.log(response);
  //    });


  MapDataService.getGadm2codes('Ethiopia')
      .then(function(response){
        response.features.forEach(function(f){
          gadm2filter.push(["==", "adm2_code", f.properties.adm2_code])
        })

        gadm2layer = {
          "layout": {
            "visibility": "visible"
          },
          "type": "fill",
          "source": "ethiopia_gadm_2014",
          "id": "ethiopia_gadm2",
          "paint": {
            "fill-outline-color": "#000000",
            "fill-color": "#56FF5E",
            "fill-opacity": ".5"
            //{
            //"base":'1',
            //"stops":[[3,.1],[5,.2],[7,.3],[8,.4],[9,.5],[10,.6],[11,.7]]
            //}
          },
          "source-layer": "data",
          "interactive": true,
          "filter": gadm2filter
        }

        //map.addLayer()

      })


  MapDataService.getGadm1codes('Ethiopia')
      .then(function(response){
        response.features.forEach(function(f){
          gadm1filter.push(["==", "adm1_code", f.properties.adm1_code])
        })

        gadm1layer = {
          "layout": {
            "visibility": "visible"
          },
          "type": "fill",
          "source": "ethiopia_gadm_2014",
          "id": "ethiopia_gadm1",
          "paint": {
            "fill-outline-color": "#000000",
            "fill-color": "#56FF5E",
            "fill-opacity": ".5"
            //{
            //"base":'1',
            //"stops":[[3,.1],[5,.2],[7,.3],[8,.4],[9,.5],[10,.6],[11,.7]]
            //}
          },
          "source-layer": "data",
          "interactive": true,
          "filter": gadm1filter
        }

        //map.addLayer(gadm1layer);

      })

  function addLayer (level) {
    if(level == 'gaul1') {
      if(map.getLayer('ethiopia_gadm2') !== undefined){
        map.removeLayer('ethiopia_gadm2')
      }
      map.addLayer(gadm1layer);
    }
    if(level == 'gaul2') {
      if(map.getLayer('ethiopia_gadm1') !== undefined){
        map.removeLayer('ethiopia_gadm1')
      }
      map.addLayer(gadm2layer);
    }
  }

  $rootScope.$on('addLayer', function (event,res){
    addLayer(res.level);
  })

  var map = new mapboxgl.Map({
    container: 'map', // container id
    //style: 'mapbox://styles/mapbox/streets-v8', //stylesheet location
    center: [41.433007, 8.145159], // starting position
    zoom: 4 // starting zoom
  });

  //map.once('load',function(){
  //  redraw()
  //})

  map.on('style.load', function () {

    //map.addSource('ethiopia_gadm_2014', {
    //  type: 'vector',
    //  tiles: ['http://54.200.155.189:3001/services/vector-tiles/ethiopia_gaul_2014/{z}/{x}/{y}.pbf']
    //});

    //map.addLayer({
    //  "layout": {
    //    "visibility": "visible"
    //  },
    //  "type": "fill",
    //  "source": "ethiopia_gadm_2014",
    //  "id": "ethiopia_gadm",
    //  "paint": {
    //    "fill-outline-color": "#000000",
    //    "fill-color": "#56FF5E",
    //    "fill-opacity": ".5"
    //    //{
    //    //"base":'1',
    //    //"stops":[[3,.1],[5,.2],[7,.3],[8,.4],[9,.5],[10,.6],[11,.7]]
    //    //}
    //  },
    //  "source-layer": "data",
    //  "interactive": true,
    //  "filter": ["any", ["==","adm2_code", 149295],
    //      ["==","adm2_code", 149295],
    //    ["==","adm2_code", 149298],
    //    ["==","adm2_code", 149295],
    //    ["==","adm2_code", 149289],
    //    ["==","adm2_code", 40850],
    //    ["==","adm2_code", 149287]]
    //});

    //map.addLayer({
    //  "id": "route-click",
    //  "type": "fill",
    //  "source": "ethiopia_gadm_2014",
    //  "source-layer": "data",
    //  "layout": {},
    //  "paint": {
    //    "fill-color": "#627BC1",
    //    "fill-opacity":.2
    //  },
    //  "filter": ["!=", "adm2_code", null]
    //});

    map.on('click', function (e) {
      // Use featuresAt to get features within a given radius of the click event
      // Use layer option to avoid getting results from other layers
      map.featuresAt(e.point, {layer: 'ethiopia_gadm', radius: 10, includeGeometry: true}, function (err, features) {
        if (err) throw err;
        // if there are features within the given radius of the click event,
        // fly to the location of the click event
        if (features.length) {
          // Get coordinates from the symbol and center the map on those coordinates
          //map.flyTo({center: features[0].geometry.coordinates});
          //console.log(features[0].properties.adm0_code + " " + features[1].properties.adm1_code);

          map.setFilter("route-click", ["==", "adm2_code", features[1].properties.adm2_code]);

          MapDataService.getDistricts(features[1].properties.adm1_code)
              .then(function(response){
                $rootScope.$broadcast('details', response);
              });
        }

      });
    });

    console.log(map);

  });

  var lastLayersStr = '';
  var lastBasemapUrl = null;
  var basemapLayer = null;
  var layersStr = null;
  var overlays = [];
  var overlayNames = [];
  var theme = null;
  var filters = null;

  $scope.params = $stateParams;
  $scope.blur = '';

  $scope.toggleState = function(stateName) {
    var state = $state.current.name !== stateName ? stateName : 'main';
    $state.go(state, $stateParams);
  };
  //

  function redraw() {
    var lat = parseFloat($stateParams.lat)   || 0;
    var lng = parseFloat($stateParams.lng)   || 0;
    var zoom = parseFloat($stateParams.zoom) || 8;
    layersStr = $stateParams.layers || LayerConfig.osm.url;
    var layers = layersStr.split(',');

    // first layer should always be treated as the basemap
    var basemap = LayerConfig.find(layers[0]) || LayerConfig.osm.url;
    if (typeof basemap === 'string') {
      var basemapUrl = basemap;
    } else {
      var basemapUrl = basemap.url;
    }
    overlayNames = layers.slice(1);

    if (lastBasemapUrl !== basemapUrl && typeof map === 'object') {
      if (basemapLayer) {
        //map.removeLayer(basemapLayer);
      }
      // draw gl map

      basemapLayer = map.setStyle(basemapUrl);

      //basemapLayer.on('load', function () {
      //  //Move to back
      //  basemapLayer.bringToBack();
      //});
    }

    if (lastLayersStr !== layersStr) {
      if(map.loaded() == true){
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

    if (typeof map === 'object' && (c.lat != 0 && c.lng !=0)) {
      //map.setView([c.lat, c.lng], zoom);
    }

    lastLayersStr = layersStr;
    lastBasemapUrl = basemapUrl;
  }
  //
  //
  /***
   * Broadcast Listeners.
   */
  $scope.$on('route-update', function() {
    if ($scope.blur === 'blur' && $state.current.name !== 'landing') {
      $scope.blur = '';
    }

    var c;
    if(!$scope.center){
      var lat = parseFloat($stateParams.lat)   || 0;
      var lng = parseFloat($stateParams.lng)   || 0;
      var zoom = parseFloat($stateParams.zoom) || 8;

      c = $scope.center = {
        lat: lat,
        lng: lng,
        zoom: zoom
      };
    }
    else{
      c = $scope.center;
    }


    var lat = c.lat.toFixed(6);
    var lng = c.lng.toFixed(6);
    var zoom = c.zoom.toString();
    if (mapMoveEnd) {
      mapMoveEnd = false;
    } else if (  $stateParams.lat     !== lat
        || $stateParams.lng     !== lng
        || $stateParams.zoom    !== zoom
        || $stateParams.layers  !== layersStr
        || $stateParams.theme   !== theme
        || $stateParams.filters !== filters   ) {

      console.log('map.js route-update Updating Map...');
      if(map.loaded() == true){
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
  map.on('move', function() { // move is good too
    var c = map.getCenter();
    var lat = c.lat.toFixed(6);
    var lng = c.lng.toFixed(6);
    var zoom = map.getZoom().toString();

    if ( $stateParams.lat !== lat
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
  function drawOverlays() {
    for (var i = 0, len = overlayNames.length; i < len; ++i) {
      var overlayName = overlayNames[i];
      var currOverlay = overlays[i];

      if (currOverlay && currOverlay.overlayName === overlayName) {
        continue; // layer is already there, continue on!
      }

      // remove the current layer that is not what should be that layer in the list
      else if (currOverlay && currOverlay._map) {
        if (currOverlay.destroyResource) currOverlay.destroyResource();
        map.removeLayer(currOverlay);
      }

      if (typeof LayerConfig[overlayName] === 'object'
        && LayerConfig[overlayName]["layer-type"].toLowerCase() === 'vector') {

        var cfg = LayerConfig[overlayName];

        // make sure make is finsihed loading

        // check to see if source exists
        if(map.getSource(cfg.source) == undefined){

        map.addSource(cfg.source, {
          type: cfg["layer-type"],
          tiles: [cfg.url]
        });

        }

        map.addLayer(cfg);

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

        map.on('click', function(e) {
          //Take the click event and pass it to the group layers.
          pbfSource.onClick(e, function (evt) {
            if (evt && evt.feature) {
              console.log(['Clicked PBF Feature', evt.feature.properties]);
            }
          });
        });

        map.on('layerremove', function(removed) {
          //This is the layer that was removed.
          //If it is a TileLayer.PBFSource, then call a method to actually remove the children, too.
          if(removed.layer.removeChildLayers){
            removed.layer.removeChildLayers(map);
          }
        });

      }

      // try for WMS (not a vector layer)
      // if things get more fancy with wms, it should get its own factory
      else if (typeof LayerConfig[overlayName] === 'object'
        && LayerConfig[overlayName].type.toLowerCase() === 'wms') {

        var cfg = LayerConfig[overlayName];
        var layer = L.tileLayer.wms(cfg.url, {
          format: cfg.format || 'image/png',
          transparent: cfg.transparent || true,
          layers: cfg.layers
        });
        layer.addTo(map);
      }

      /**
       * Tiles that are an overlay. OSM / Google / Mapnik tend to make tiles in this format.
       */
      else if (typeof LayerConfig[overlayName] === 'object'
        && LayerConfig[overlayName].type.toLowerCase() === 'xyz') {

        var cfg = LayerConfig[overlayName];
        var layer = L.tileLayer(cfg.url, {
          opacity: cfg.opacity || 0.5
        });
        layer.addTo(map);
      }

      /**
       * TMS flips the y. GeoServer often serves this.
       */
      else if (typeof LayerConfig[overlayName] === 'object'
        && LayerConfig[overlayName].type.toLowerCase() === 'tms') {
        var cfg = LayerConfig[overlayName];
        var layer = L.tileLayer(cfg.url, {
          opacity: cfg.opacity || 0.5,
          tms: true
        });
        layer.addTo(map);
      }

      // if its not wms, its a vector layer
      else {
        var vecRes = VectorProvider.createResource(overlayName);
        var layer = vecRes.getLayer();
        layer.addTo(map);
      }

      cfg.overlayName = overlayName;
      overlays[i] = cfg;

    }

    // there are more overlays left in the list, less layers specified in route
    // we need to remove those too.
    for (var len2 = overlays.length; i < len2; ++i) {
      //if (overlays[i].destroyResource) overlays[i].destroyResource();
      map.removeLayer(overlays[i].id);
      delete overlays[i];
    }

  }

});