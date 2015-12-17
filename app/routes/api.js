var express = require('express');
var router = express.Router();
var pg = require('../pg');



/*
 * Get list of all organizations
 */
router.get('/organizations', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "organization_id,title";

    var sql = pg.featureCollectionSQL("organization", columnsToGet);
    var preparedStatement = {
        name: "get_all_organizations",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement)
        .then(function(result){
            res.send(JSON.stringify(result[0].response));
        })
        .catch(function(err){
            next(err);
        });
});



/*
 * Get list of all countries
 */
router.get('/countries', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "country_id, code, title, description, image_path";

    var sql = pg.featureCollectionSQL("country", columnsToGet);
    var preparedStatement = {
        name: "get_all_countries",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement)
        .then(function(result){
            res.send(JSON.stringify(result[0].response));
        })
        .catch(function(err){
            next(err);
        });
});



/*
 * Get list of all districts
 */
router.get('/districts', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "district_id, district_title,country_id, code, title, description, image_path";

    var sql = pg.featureCollectionSQL("country_district", columnsToGet);
    var preparedStatement = {
        name: "get_all_districts",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement)
        .then(function(result){
            var results = result[0].response;
            var response = [];

            results.features.forEach(function(district) {
                var district_data = {};

                district_data.district_id = district.properties.district_id;
                district_data.title = district.properties.district_title;
                district_data.country = {};

                district_data.country.country_id = district.properties.country_id;
                district_data.country.code = district.properties.code;
                district_data.country.title = district.properties.title;
                district_data.country.description = district.properties.description;
                district_data.country.image_path = district.properties.image_path;

                response.push(district_data);

            });
            res.send(JSON.stringify(response));
        })
        .catch(function(err){
            next(err);
        });
});


/*
 * Get list of all districts
 */
router.get('/sites', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "site_id, village_id, site_title, site_image_path, district_id, district_title,country_id, code, title, description, image_path";

    var sql = pg.featureCollectionSQL("country_district_site", columnsToGet);
    var preparedStatement = {
        name: "get_all_sites",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement)
        .then(function(result){
            var results = result[0].response;
            var response = [];

            results.features.forEach(function(site) {

                var site_data = {};

                site_data.site_id = site.properties.site_id;
                site_data.village_id = site.properties.village_id;
                site_data.title = site.properties.site_title;

                site_data.district = {};
                site_data.district.district_id = site.properties.district_id;
                site_data.district.title = site.properties.district_id;

                site_data.district.country = {};
                site_data.district.country.country_id = site.properties.country_id;
                site_data.district.country.code = site.properties.code;
                site_data.district.country.title = site.properties.title;
                site_data.district.country.description = site.properties.description;
                site_data.district.country.image_path = site.properties.image_path;

                response.push(site_data);

            });
            res.send(JSON.stringify(response));
        })
        .catch(function(err){
            next(err);
        });
});




/*
 * Get list of all states
 */
router.get('/states', function(req, res, next) {
    console.log('get all states');


    // All columns in table with the exception of the geometry column
    var nonGeomColumns = "id,name";

    var sql = pg.featureCollectionSQL("state", nonGeomColumns);
    var preparedStatement = {
        name: "get_all_states",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement)
        .then(function(result){
            res.send(JSON.stringify(result[0]));
        })
        .catch(function(err){
            next(err);
        });


});

/*
 * Get all state data
 */
router.get('/all-state-data', function(req, res, next) {
    console.log('get album votes');


    // All columns in table with the exception of the geometry column
    var nonGeomColumns = "state_id, indicator_id, indicator_value, indicator_title, name";

    var sql = pg.featureCollectionSQL("full_state_data_info", nonGeomColumns);
    var preparedStatement = {
        name: "get_full_state_data_info",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement)
        .then(function(result){
            res.send(JSON.stringify(result[0]));
        })
        .catch(function(err){
            next(err);
        });

});



module.exports = router;



