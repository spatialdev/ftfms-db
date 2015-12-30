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
    'basic', 'bright', 'streets', 'light', 'dark'
];


/**
 * Basemaps
 *
 * All basemap aliases that can be referred to in the url. The corresponding
 * path to the thumbnail in the Basemaps Panel should be:
 *    images/{aliasName}.jpg
 *
 */

layers.basic = {
    url: 'mapbox://styles/mapbox/basic-v8',
    name: 'Basic',
    "layer-type": 'basemap'
};

layers.bright = {
    url: 'mapbox://styles/mapbox/bright-v8',
    name: 'Bright',
    "layer-type": 'basemap'
};
layers.streets = {
    url: 'mapbox://styles/mapbox/streets-v8',
    name: 'Streets',
    "layer-type": 'basemap'
};
layers.light = {
    url: 'mapbox://styles/mapbox/light-v8',
    name: 'Light',
    "layer-type": 'basemap'
};
layers.dark = {
    url: 'mapbox://styles/mapbox/dark-v8',
    name: 'Dark',
    "layer-type": 'basemap'
};


/**
 *
 * FTFMS DB Country List
 *
 */


layers.ethiopia_gadm_2014 = {
    "id":"ethiopia_adm",
    "layer-type": "vector",
    "source":"ethiopia_gadm_2014",
    "url": "http://54.200.155.189:3001/services/vector-tiles/ethiopia_gadm_2014/{z}/{x}/{y}.pbf",
    "layers": [
        {
            "id":"ethiopia_adm0",
            "layout": {
                "visibility": "visible"
            },
            "source":"ethiopia_gadm_2014",
            "source-layer": "adm0",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"ethiopia_adm1",
            "layout": {
                "visibility": "visible"
            },
            "source":"ethiopia_gadm_2014",
            "source-layer": "adm1",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"ethiopia_adm2",
            "layout": {
                "visibility": "visible"
            },
            "source":"ethiopia_gadm_2014",
            "source-layer": "adm2",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        }
    ]
};

layers.kenya_gadm_2014 = {
    "id":"kenya_gadm",
    "layer-type": "vector",
    "source":"kenya_gadm_2014",
    "url": "http://54.200.155.189:3001/services/vector-tiles/kenya_gadm_2014/{z}/{x}/{y}.pbf",
    "layers": [
        {
            "id":"kenya_adm0",
            "layout": {
                "visibility": "visible"
            },
            "source":"kenya_gadm_2014",
            "source-layer": "adm0",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"kenya_adm1",
            "layout": {
                "visibility": "visible"
            },
            "source":"kenya_gadm_2014",
            "source-layer": "adm1",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"kenya_adm2",
            "layout": {
                "visibility": "visible"
            },
            "source":"kenya_gadm_2014",
            "source-layer": "adm2",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        }
    ]
};

layers.senegal_gadm_2014 = {
    "id":"senegal_gadm",
    "layer-type": "vector",
    "source":"senegal_gadm_2014",
    "url": "http://54.200.155.189:3001/services/vector-tiles/senegal_gadm_2014/{z}/{x}/{y}.pbf",
    "layers": [
        {
            "id":"senegal_adm0",
            "layout": {
                "visibility": "visible"
            },
            "source":"senegal_gadm_2014",
            "source-layer": "adm0",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"senegal_adm1",
            "layout": {
                "visibility": "visible"
            },
            "source":"senegal_gadm_2014",
            "source-layer": "adm1",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"senegal_adm2",
            "layout": {
                "visibility": "visible"
            },
            "source":"senegal_gadm_2014",
            "source-layer": "adm2",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        }
    ]
};

layers.bangladesh_gadm_2014 = {
    "id":"bangladesh_gadm",
    "layer-type": "vector",
    "source":"bangladesh_gadm_2014",
    "url": "http://54.200.155.189:3001/services/vector-tiles/bangladesh_gadm_2014/{z}/{x}/{y}.pbf",
    "layers": [
        {
            "id":"bangladesh_adm0",
            "layout": {
                "visibility": "visible"
            },
            "source":"bangladesh_gadm_2014",
            "source-layer": "adm0",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"bangladesh_adm1",
            "layout": {
                "visibility": "visible"
            },
            "source":"bangladesh_gadm_2014",
            "source-layer": "adm1",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        },
        {
            "id":"bangladesh_adm2",
            "layout": {
                "visibility": "visible"
            },
            "source":"bangladesh_gadm_2014",
            "source-layer": "adm2",
            "interactive": true,
            "type": "fill",
            "paint": {
                "fill-outline-color": "#000000",
                "fill-color": "#56FF5E",
                "fill-opacity": ".5"
            }
        }
    ]
};