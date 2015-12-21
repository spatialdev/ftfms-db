/**
 * Created by Nicholas Hallahan <nhallahan@spatialdev.com>
 *       on 8/15/14.
 */

var debug = {};

// panel
var open = 0;
$(".trigger").click(function() {
  if (open == 0) {
    //$('#start-input').focus();
    $(".trigger").animate({ "right": "+=300px" }, "fast");
    $(".block").animate({ "right": "+=300px" }, "fast", function() {
      $('#start-input').focus();
    });

    open = 1;
  }
  else if (open == 1) {
    $(".block").animate({ "right": "-=300px" }, "fast");
    $(".trigger").animate({ "right": "-=300px" }, "fast");
    open = 0;
  }
});

var map = L.map('map').setView([0,39], 6); // africa
//    var map = L.map('map').setView([19.6,-155.4], 8); // hawaii

L.tileLayer('http://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
  maxZoom: 18
}).addTo(map);


var pbfSource = new L.TileLayer.PBFSource({
  url: "http://spatialserver.spatialdev.com/services/postgis/cicos_2013/geom/vector-tiles/{z}/{x}/{y}.pbf",
//        url: "https://a.tiles.mapbox.com/v3/mapbox.mapbox-terrain-v1,mapbox.mapbox-streets-v5/{z}/{x}/{y}.vector.pbf",
  debug: true,
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
//    if (feature.layer.name === 'gadm1_label' || feature.layer.name === 'gadm1') {
//      return true;
//    }

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
      return layerName.replace('_label','');
    }
    return layerName + '_label';
  },

  styleFor: pbfStyle
});
debug.pbfSource = pbfSource;

//Globals that we can change later.
var fillColor = 'rgba(149,139,255,0.4)';
var strokeColor = 'rgb(20,20,20)';


function pbfStyle(feature) {
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
      style.color = fillColor;
      style.outline = {
        color: strokeColor,
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

map.on("click", function(e) {
  //Take the click event and pass it to the group layers.

  pbfSource.onClick(e, function (evt) {
    if (evt && evt.feature) {
      //alert("Clicked Country: " + evt.feature.name_0);
      $("#idResults").html("Clicked Country: " + evt.feature.properties.name_0);
    }
  });
});

map.on("layerremove", function(removed){
  //This is the layer that was removed.
  //If it is a TileLayer.PBFSource, then call a method to actually remove the children, too.
  if(removed.layer.removeChildLayers){
    removed.layer.removeChildLayers(map);
  }
});

pbfSource.bind("PBFLoad", function(){
  //Fired when all PBFs have been processed and map has finished rendering.
  console.log("done rendering.");
});

//Add layer
map.addLayer(pbfSource);


function loadLayers() {
  //Load layer list
  var layers = pbfSource.getLayers();
  var layerIds = Object.keys(layers);

  layerIds.forEach(function(key, idx){
    //var key = layerIds[idx];
    //loop thru layers and list them in the panel
    var layer = layers[key];
    var row = $('<div class="VTSubLayer"><label class="checkbox">' + key + '</label></div>').appendTo($("#layerList"));
    var cBox = $('<input type="checkbox" checked="checked" value="all">').appendTo(row);

    cBox.on("click", function(evt) {
      //Toggle layer visiblity
      if (layer.visible == true) {
        pbfSource.hideLayer(key);
      }
      else {
        pbfSource.showLayer(key);
        pbfSource.redraw();
      }
    });
  })
}

function removePBFLayer(){
  map.removeLayer(pbfSource);
}

function updateStyle() {
  var cssFill = $("#cssFill").val();
  var cssStroke = $("#cssStroke").val();

  if (cssFill) fillColor = cssFill;
  if (cssStroke) strokeColor = cssStroke;
  pbfLayerGroup.redraw();
}
