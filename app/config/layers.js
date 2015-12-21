/**
 * Created by Nicholas Hallahan <nhallahan@spatialdev.com>
 *       on 9/10/14.
 *
 * This file defines the layers that are known in SpatialViewer.
 * This is done as a global object called layers
 *
 */

var layers = {};


/**
 * Basemaps Panel List
 *
 * List of basemaps that get shown in the Basemaps Panel. Edit this to add or remove
 * basemaps that the user will see as choices. All basemaps, including ones not in this
 * list, can still be manually referenced in the url. This is just for the User Interface.
 */
layers.basemaps = [
  'osmhot',
  'osm',
  'satellite',
  'ortho',
  'toner',
  'dark',
  'github',
  'mozilla',
  'green',
  'osmcycle',
  'osmtransport',
  'osmmapquest',
  'natgeo',
  'usgstopo',
  'esritopo',
  'ocean',
  'lightgray',
  'watercolor'
];


/**
 * Basemaps
 *
 * All basemap aliases that can be referred to in the url. The corresponding
 * path to the thumbnail in the Basemaps Panel should be:
 *    images/{aliasName}.jpg
 *
 */

layers.osmhot = {
  url: 'http://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
  name: 'Humanitarian OpenStreetMap',
  type: 'basemap'
};

layers.redcross = {
  url: 'https://{s}.tiles.mapbox.com/v3/americanredcross.hcji22de/{z}/{x}/{y}.png',
  name: 'Red Cross',
  type: 'basemap'
};

layers.satellite = {
  url: 'https://{s}.tiles.mapbox.com/v3/examples.map-qfyrx5r8/{z}/{x}/{y}.png',
  name: 'Mapbox Satellite',
  type: 'basemap'
};

layers.mozilla = {
  url: 'http://{s}.tiles.mapbox.com/v3/mozilla-webprod.e91ef8b3/{z}/{x}/{y}.png',
  name: 'Mozilla',
  type: 'basemap'
};

layers.github = {
  url: 'http://{s}.tiles.mapbox.com/v3/github.map-xgq2svrz/{z}/{x}/{y}.png',
  name: 'Github',
  type: 'basemap'
};

layers.green = {
  url: 'http://{s}.tiles.mapbox.com/v3/examples.map-3gisupiu/{z}/{x}/{y}.png',
  name: 'Green Theme',
  type: 'basemap'
};

layers.dark = {
  url: 'http://{s}.tiles.mapbox.com/v3/spatialdev.map-c9z2cyef/{z}/{x}/{y}.png',
  name: 'Dark Theme',
  type: 'basemap'
};

layers.osm = {
  url: 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
  name: 'Standard OpenStreetMap',
  type: 'basemap'
};

layers.osmcycle = {
  url: 'http://{s}.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png',
  name: 'Cycle OpenStreetMap',
  type: 'basemap'
};

layers.osmtransport = {
  url: 'http://{s}.tile2.opencyclemap.org/transport/{z}/{x}/{y}.png',
  name: 'Transport OpenStreetMap',
  type: 'basemap'
};

layers.osmmapquest = {
  url: 'http://otile3.mqcdn.com/tiles/1.0.0/osm/{z}/{x}/{y}.png',
  name: 'MapQuest OpenStreetMap',
  type: 'basemap'
};

layers.natgeo = {
  url: 'http://services.arcgisonline.com/ArcGIS/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}',
  name: 'National Geographic',
  type: 'basemap'
};

layers.usgstopo = {
  url: 'http://services.arcgisonline.com/ArcGIS/rest/services/USA_Topo_Maps/MapServer/tile/{z}/{y}/{x}',
  name: 'USGS Topographic',
  type: 'basemap'
};

layers.ortho = {
  url: 'http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  name: 'Orthographic',
  type: 'basemap'
};

layers.ocean = {
  url: 'http://services.arcgisonline.com/ArcGIS/rest/services/Ocean/World_Ocean_Base/MapServer/tile/{z}/{y}/{x}',
  name: 'Ocean Bathymetric',
  type: 'basemap'
};

layers.lightgray = {
  url: 'http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}',
  name: 'Light Gray',
  type: 'basemap'
};

layers.esritopo = {
  url: 'http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
  name: 'Esri Topographic',
  type: 'basemap'
};

layers.toner = {
  url: 'http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png',
  name: 'Stamen Toner',
  type: 'basemap'
};

layers.watercolor = {
  url: 'http://{s}.tile.stamen.com/watercolor/{z}/{x}/{y}.png',
  name: 'Stamen Watercolor',
  type: 'basemap'
};


/**
 * CSV
 */

layers.ugandafsp = {
  name: 'Uganda Financial Service providers',
  type: 'csv',
  url: 'data/test/uganda.csv',
  properties: {
    legend: ''
  }
};

layers.sampletracks = {
  name: 'Sample GPS Tracks',
  type: 'csv',
  url: 'data/test/sample-tracks.csv',
  properties: {
    legend: ''
  }
};


/**
 * GeoJSON
 *
 * Note: Specifying the properties extends the properties object of the retrieved GeoJSON.
 * Styling adheres to the Github/Mapbox GeoJSON Styling Spec:
 *
 * https://help.github.com/articles/mapping-geojson-files-on-github
 * https://github.com/mapbox/simplestyle-spec/tree/master/1.1.0
 *
 */

layers.usgsearthquake = {
  type: 'geojson',
  url: 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_week.geojson',
  properties: {
    'title': 'USGS Realtime Earthquakes Feed (Week)'

  }
};

layers.phl = {
  type: 'geojson',
  url: 'data/test/phl.geojson',
  properties: {
    "title": 'The Philippines',
    "stroke": 'white',
    "stroke-width": 2,
    "dash-array": '3',
    "stroke-opacity": 1,
    "fill": "green",
    "fill-opacity": 0.7,
    legend: ""
  }
};

layers.wa = {
  type: 'geojson',
  url: 'data/test/washington.geojson',
  properties: {
    title: 'Washington (State)',
    fill: "#FFBE00",
    legend: ""
  }
};

layers.wafires = {
  type: 'geojson',
  url: 'data/test/state_wa_lrg_fires.geojson',
  properties: {
    "title": "Washington Fires",
    "stroke": "#FF8800",
    "stroke-width": 1,
    "fill": "#FFBE00",
    "fill-opacity": 0.5,
    legend: ""
  }
};


/**
 * KML
 */

layers.gdacs = {
  name: 'GDACS: Global Disaster Alert and Coordination System',
  type: 'kml',
  url: 'http://www.gdacs.org/xml/gdacs.kml',
  properties: {
    legend: ''
  }
};

layers.gdacstest = {
  name: 'GDACS Test',
  type: 'kml',
  url: 'data/test/gdacs.kml',
  properties: {
    legend: ''
  }
};

layers.earthquakes = {
  name: 'USGS Earthquakes',
  type: 'kml',
  url: 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_week_age.kml',
  properties: {
    legend: ''
  }
};

layers.earthquakestest = {
  name: 'USGS Earthquakes Test',
  type: 'kml',
  url: 'data/test/usgs-earthquakes.kml',
  properties: {
    legend: ''
  }
};


/**
 * Other (Vector Provider attempts to figure out the vector type)
 */
layers.usoutline = 'http://eric.clst.org/wupl/Stuff/gz_2010_us_outline_20m.json';


/**
 * WMS
 */

layers.airtemp = {
  name: 'NOAA Air Temperature',
  type: 'wms',
  url: 'http://nowcoast.noaa.gov/wms/com.esri.wms.Esrimap/obs',
  transparent: true,      // default true
  format: 'image/png',    // default 'image/png'
  layers: 'OBS_MET_TEMP',
  properties: {
    legend: ""
  }
};

layers.landcover = {
  name: 'MODIS Landcover 2009',
  type: 'wms',
  url: 'http://ags.servirlabs.net/ArcGIS/services/ReferenceNode/MODIS_Landcover_Type1_2009/MapServer/WMSServer',
  layers: '0',
  properties: {
    legend: ""
  }
};

layers.growingperiod = {
  name: 'Average Length of Growing Period (days)',
  type: 'wms',
  url: 'http://apps.harvestchoice.org/arcgis/services/MapServices/cell_values_4/MapServer/WMSServer',
  layers: '15',
  properties: {
    legend: ""
  }
};


/**
 * XYZ
 */
layers.clouds = {
  name: 'Cloud Cover',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/clouds_cls/{z}/{x}/{y}.png',
  opacity: 0.5 // optional. opacity is 0.5 if not specified
};

layers.precipitation = {
  name: 'Precipitation',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/precipitation/{z}/{x}/{y}.png',
  opacity: 0.5
};

layers.precipitationclassic = {
  name: 'Precipitation (Classic)',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/precipitation_cls/{z}/{x}/{y}.png',
  opacity: 0.4
};

layers.rain = {
  name: 'Rain',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/rain/{z}/{x}/{y}.png'
};

layers.rainclassic = {
  name: 'Rain (Classic)',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/rain_cls/{z}/{x}/{y}.png'
};

layers.pressure = {
  name: 'Pressure',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/pressure/{z}/{x}/{y}.png'
};

layers.pressurecontour = {
  name: 'Pressure Contour',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/pressure_cntr/{z}/{x}/{y}.png',
  opacity: 0.9
};

layers.temperature = {
  name: 'Temperature',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/temp/{z}/{x}/{y}.png'
};

layers.wind = {
  name: 'Wind',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/wind/{z}/{x}/{y}.png'
};

layers.snow = {
  name: 'Snow',
  type: 'xyz',
  url: 'http://{s}.tile.openweathermap.org/map/snow/{z}/{x}/{y}.png'
};


layers.gadm2014kenya = {
  type: 'pbf',
  name: 'GADM 2014 Kenya',
  url: "http://spatialserver.spatialdev.com/services/vector-tiles/gadm2014kenya/{z}/{x}/{y}.pbf",
  debug: false,
  clickableLayers: ['gadm0', 'gadm1', 'gadm2', 'gadm3', 'gadm4', 'gadm5'],

  getIDForLayerFeature: function(feature) {
    return feature.properties.id;
  },

  /**
   * The filter function gets called when iterating though each vector tile feature (vtf). You have access
   * to every property associated with a given feature (the feature, and the layer). You can also filter
   * based of the context (each tile that the feature is drawn onto).
   *
   * Returning false skips over the feature and it is not drawn.
   *
   * @param feature
   * @returns {boolean}
   */
  filter: function(feature, context) {
    if (feature.layer.name === 'gadm1_label' || feature.layer.name === 'gadm1') {
      return true;
    }

    return false;
  },

  /**
   * When we want to link events between layers, like clicking on a label and a
   * corresponding polygon freature, this will return the corresponding mapping
   * between layers. This provides knowledge of which other feature a given feature
   * is linked to.
   *
   * @param layerName  the layer we want to know the linked layer from
   * @returns {string} returns corresponding linked layer
   */
  layerLink: function(layerName) {
    if (layerName.indexOf('_label') > -1) {
      return layerName.replace('_label', '');
    }
    return layerName + '_label';
  },

  styleFor: function(feature) {
    var style = {};
    var selected = style.selected = {};

    var type = feature.type;
    switch (type) {
      case 1: //'Point'
        // unselected
        style.color = '#ff0000';
        style.radius = 5;
        // selected
        selected.color = 'rgba(255,255,0,0.5)';
        selected.radius = 5;
        break;
      case 2: //'LineString'
        // unselected
        style.color = 'rgba(161,217,155,0.8)';
        style.size = 3;
        // selected
        selected.color = 'rgba(255,25,0,0.5)';
        selected.size = 3;
        break;
      case 3: //'Polygon'
        // unselected
        style.color = 'rgba(149,139,255,0.4)';
        style.outline = {
          color: 'rgb(20,20,20)',
          size: 2
        };
        // selected
        selected.color = 'rgba(255,25,0,0.3)';
        selected.outline = {
          color: '#d9534f',
          size: 3
        };
    }

    if (feature.layer.name === 'gadm1_label') {
      style.staticLabel = function() {
        var style = {
          html: feature.properties.name,
          iconSize: [125,30],
          cssClass: 'label-icon-text'
        };
        return style;
      };
    }

    return style;
  }
};


layers.gaul_fsp = {
  type: 'pbf',
  name: 'GAUL FSP',
  url: "http://spatialserver.spatialdev.com/services/vector-tiles/GAUL_FSP/{z}/{x}/{y}.pbf",
  debug: false,
  clickableLayers: [],

  getIDForLayerFeature: function(feature) {
    return "";
  },

  /**
   * The filter function gets called when iterating though each vector tile feature (vtf). You have access
   * to every property associated with a given feature (the feature, and the layer). You can also filter
   * based of the context (each tile that the feature is drawn onto).
   *
   * Returning false skips over the feature and it is not drawn.
   *
   * @param feature
   * @returns {boolean}
   */
  filter: function(feature, context) {
    return true;
  },

  /**
   * When we want to link events between layers, like clicking on a label and a
   * corresponding polygon freature, this will return the corresponding mapping
   * between layers. This provides knowledge of which other feature a given feature
   * is linked to.
   *
   * @param layerName  the layer we want to know the linked layer from
   * @returns {string} returns corresponding linked layer
   */
  layerLink: function(layerName) {
    if (layerName.indexOf('_label') > -1) {
      return layerName.replace('_label', '');
    }
    return layerName + '_label';
  },

  styleFor: function(feature) {
    var style = {};
    var selected = style.selected = {};

    var type = feature.type;
    switch (type) {
      case 1: //'Point'
        // unselected
        style.color = '#ff0000';
        style.radius = 5;
        // selected
        selected.color = 'rgba(255,255,0,0.5)';
        selected.radius = 5;
        break;
      case 2: //'LineString'
        // unselected
        style.color = 'rgba(161,217,155,0.8)';
        style.size = 3;
        // selected
        selected.color = 'rgba(255,25,0,0.5)';
        selected.size = 3;
        break;
      case 3: //'Polygon'
        // unselected
        style.color = 'rgba(149,139,255,0.4)';
        style.outline = {
          color: 'rgb(20,20,20)',
          size: 2
        };
        // selected
        selected.color = 'rgba(255,25,0,0.3)';
        selected.outline = {
          color: '#d9534f',
          size: 3
        };
    }

    return style;
  }

};


layers.cicos = {
  type: 'pbf',
  name: 'FSP CICO Points',
  url: "http://spatialserver.spatialdev.com/services/vector-tiles/FSPCicos2013/{z}/{x}/{y}.pbf",
  debug: false,
  clickableLayers: [],

  getIDForLayerFeature: function(feature) {
    return "";
  },

  /**
   * The filter function gets called when iterating though each vector tile feature (vtf). You have access
   * to every property associated with a given feature (the feature, and the layer). You can also filter
   * based of the context (each tile that the feature is drawn onto).
   *
   * Returning false skips over the feature and it is not drawn.
   *
   * @param feature
   * @returns {boolean}
   */
  filter: function(feature, context) {
    //return feature.properties.type != 'Mobile Money Agent';
    return true;
  },

  /**
   * When we want to link events between layers, like clicking on a label and a
   * corresponding polygon freature, this will return the corresponding mapping
   * between layers. This provides knowledge of which other feature a given feature
   * is linked to.
   *
   * @param layerName  the layer we want to know the linked layer from
   * @returns {string} returns corresponding linked layer
   */
  layerLink: function(layerName) {
    if (layerName.indexOf('_label') > -1) {
      return layerName.replace('_label', '');
    }
    return layerName + '_label';
  },

  /**
   * Specify which features should have a certain z index (integer).  Lower numbers will draw on 'the bottom'.
   *
   * @param feature - the PBFFeature that contains properties
   */
  layerOrdering: function(feature){
    //This only needs to be done for each type, not necessarily for each feature. But we'll start here.
    if(feature && feature.properties){
      feature.properties.zIndex = layers.cicos.cicoConfig[feature.properties.type].zIndex || 5;
    }
  },

  // All possible CICO layer (combined from all countries)
  cicoConfig: {
    'Offsite ATMs': {
      color: '#3086AB',
      infoLabel: 'Offsite ATM',
      providers: null,
      zIndex: 3
    },
    'Bank Branches': {
      color: '#977C00',
      infoLabel: 'Bank Branch',
      providers: null,
      zIndex: 2
    },
    'MFIs': {
      color: '#9B242D',
      infoLabel: 'MFI',
      providers: null,
      zIndex: 1
    },
    'SACCOs': {
      color: '#cf8a57',
      infoLabel: 'SACCO',
      providers: null,
      zIndex: 10
    },
    'Mobile Money Agent': {
      color: '#8CB7C7',
      infoLabel: 'Mobile Money Agent',
      providers: null,
      zIndex: -1
    },
    'MDIs': {
      color: '#825D99',
      infoLabel: 'MDI',
      providers: null,
      zIndex: 6
    },
    'Credit Institution': {
      color: '#6CA76B',
      infoLabel: 'Credit Institution',
      providers: null,
      zIndex: 5
    },
    'MFBs': {
      color: '#825D99',
      infoLabel: 'MFB',
      providers: null,
      zIndex: 7
    },
    'Motor Parks': {
      color: '#bd85b3',
      infoLabel: 'Motor Parks',
      providers: null,
      zIndex: 7
    },
    'Mobile Network Operator Outlets': {
      color: '#a2a2a2',
      infoLabel: 'Mobile Network Operator Outlets',
      providers: null,
      zIndex: 0
    },
    'Post Offices': {
      color: '#80ad7b',
      infoLabel: 'Post Offices',
      providers: null,
      zIndex: 5
    },
    'Post Office': {
      color: '#80ad7b',
      infoLabel: 'Post Offices',
      providers: null,
      zIndex: 6
    },
    'Bus Stand': {
      color: '#80ad7b',
      infoLabel: 'Bus Stands',
      providers: null,
      zIndex: 6
    },
    'Bus Stands': {
      color: '#80ad7b',
      infoLabel: 'Bus Stands',
      providers: null,
      zIndex: 6
    },

    //Kenya
    'Insurance Providers': {
      color: '#3086AB',
      infoLabel: 'Insurance providers',
      providers: null,
      zIndex: 6
    },
    'Money Transfer Service': {
      color: '#977C00',
      infoLabel: 'Money Transfer Service',
      providers: null,
      zIndex: 6
    },
    'Dev Finance': {
      color: '#9B242D',
      infoLabel: 'Dev Finance',
      providers: null,
      zIndex: 6
    },
    'Forex Bureaus': {
      color: '#cf8a57',
      infoLabel: 'Forex Bureaus',
      providers: null,
      zIndex: 6
    },
    'Cap Markets': {
      color: '#825D99',
      infoLabel: 'Cap Markets',
      providers: null,
      zIndex: 6
    },
    'Pension Providers': {
      color: '#a2a2a2',
      infoLabel: 'Pension providers',
      providers: null,
      zIndex: 6
    },
    'Purchase Lease Factoring': {
      color: '#80ad7b',
      infoLabel: 'Purchase Lease Factoring',
      providers: null,
      zIndex: 6
    },
    'Bank Agent': {
      color: '#80ad7b',
      infoLabel: 'Bank Agent',
      providers: null,
      zIndex: 6
    },
    'Bank and Mortgage': {
      color: '#80ad7b',
      infoLabel: 'Banks and Mortgage',
      providers: null,
      zIndex: 6
    },
    'Commercial Bank': {
      color: '#80ad7b',
      infoLabel: 'Commercial Bank',
      providers: null,
      zIndex: 6
    },
    'PostBank': {
      color: '#bd85b3',
      infoLabel: 'Post Bank',
      providers: null,
      zIndex: 6
    },

    //Nigeria New Post Offices
    'NIPOST Post Office': {
      color: '#80ad7b',
      infoLabel: 'NIPOST Post Offices',
      providers: null,
      zIndex: 6
    },
    'NIPOST Post Shop': {
      color: '#80ad7b',
      infoLabel: 'NIPOST Post Shops',
      providers: null,
      zIndex: 6
    },
    'NIPOST Postal Agency': {
      color: '#80ad7b',
      infoLabel: 'NIPOST Postal Agencies',
      providers: null,
      zIndex: 6
    }
  },

  styleFor: function(feature) {
    var style = {};
    var selected = style.selected = {};
    var pointRadius = 1;

    function ScaleDependentPointRadius(zoom){
      //Set point radius based on zoom
      var pointRadius = 1;
      if(zoom >= 0 && zoom <= 7){
        pointRadius = 1;
      }
      else if(zoom > 7 && zoom <= 10){
        pointRadius = 3;
      }
      else if(zoom > 10){
        pointRadius = 4;
      }

      return pointRadius;
    }

    var type = feature.type;
    switch (type) {
      case 1: //'Point'
        // unselected
        style.color = layers.cicos.cicoConfig[feature.properties.type].color || '#3086AB';
        style.radius = ScaleDependentPointRadius;
        // selected
        selected.color = 'rgba(255,255,0,0.5)';
        selected.radius = 5;
        break;
      case 2: //'LineString'
        // unselected
        style.color = 'rgba(161,217,155,0.8)';
        style.size = 3;
        // selected
        selected.color = 'rgba(255,25,0,0.5)';
        selected.size = 3;
        break;
      case 3: //'Polygon'
        // unselected
        style.color = 'rgba(149,139,255,0.4)';
        style.outline = {
          color: 'rgb(20,20,20)',
          size: 2
        };
        // selected
        selected.color = 'rgba(255,25,0,0.3)';
        selected.outline = {
          color: '#d9534f',
          size: 3
        };
    }

    return style;
  }

};
