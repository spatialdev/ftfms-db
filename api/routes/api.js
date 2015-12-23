var express = require('express');
var router = express.Router();
var pg = require('../../pg');



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
 * Get all data related to a report
 */
router.get('/report_details/:report_id', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "report_id, report_title, indicator_id, indicator_title, code, country_id, district_id, site_id, organization_id";

    var wc = {whereClause :"WHERE report_id = $1" };

    var sql = pg.featureCollectionSQL("report_details", columnsToGet, wc);
    var preparedStatement = {
        name: "get_one_report",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement, {sqlParams: [req.params.report_id]})
        .then(function(result){
            var results = result[0].response.features;

            if (results) {
                var report = {};
                report.report_id = results[0].properties.report_id;
                report.title = results[0].properties.report_title;
                report.country_id = results[0].properties.country_id;
                report.district_id = results[0].properties.district_id;
                report.site_id = results[0].properties.site_id;

                report.indicators = [];

                results.forEach(function(indicator) {

                    var indicator_data = {};

                    indicator_data.indicator_id = indicator.properties.indicator_id;
                    indicator_data.title = indicator.properties.indicator_title;
                    indicator_data.code = indicator.properties.code;
                    indicator_data.indicator_id = indicator.properties.indicator_id;

                    report.indicators.push(indicator_data);
                });

                res.send(JSON.stringify(report));
            }
            else {
                res.send(JSON.stringify({status:"error", msg:"Report does not exist"}));
            }

        })
        .catch(function(err){
            res.send(JSON.stringify({status:"error", msg:err.message}));
            next(err);
        });
});



/*
 * Get all data related to a organization/prime partner
 */
router.get('/organization_details/:organization_id', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "organization_id, title, report_id, country_id, district_id, site_id, organization_id";

    var wc = {whereClause :"WHERE organization_id = $1" };

    var sql = pg.featureCollectionSQL("organization_details", columnsToGet, wc);
    var preparedStatement = {
        name: "get_one_organization_details",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement, {sqlParams: [req.params.organization_id]})
        .then(function(result){
            var results = result[0].response.features;

            if (results) {
                var organization = {};
                organization.organization_id = results[0].properties.organization_id;
                organization.title = results[0].properties.title;
                organization.report_id = results[0].properties.report_id;
                organization.country_id = results[0].properties.country_id;
                organization.district_id = results[0].properties.district_id;
                organization.site_id = results[0].properties.site_id;

                res.send(JSON.stringify(organization));
            }
            else {
                res.send(JSON.stringify({status:"error", msg:"Organization does not exist"}));
            }

        })
        .catch(function(err){
            next(err);
        });
});


/*
 * Get summary data by location
 */
router.get('/summary_by_location', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "report_count, organization_count, country_id, district_id, site_id, country_title, district_title, site_title";

    var sql = pg.featureCollectionSQL("summary_data_by_location", columnsToGet);
    var preparedStatement = {
        name: "get_all_summary_data_by_location",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement)
        .then(function(result){
            var results = result[0].response;

            res.send(JSON.stringify(results));
        })
        .catch(function(err){
            next(err);
        });
});



/*
 * Get summary data by country
 */
router.get('/country_summary_data/:adm0_code', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "report_count, organization_count, country_id, country_title, adm0_code";

    var wc = {whereClause :"WHERE adm0_code = $1" };

    var sql = pg.featureCollectionSQL("summary_data_by_country", columnsToGet, wc);
    var preparedStatement = {
        name: "get_one_country_summary_data",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement, {sqlParams: [req.params.adm0_code]})
        .then(function(result){
            var results = result[0].response.features;

            if (results) {
                res.send(JSON.stringify(results));
            }
            else {
                res.send(JSON.stringify({status:"error", msg:"Country summary does not exist"}));
            }
        })
        .catch(function(err){
            next(err);
        });
});



/*
 * Get summary data by district
 */
router.get('/district_summary_data/:adm1_code', function(req, res, next) {


    // Columns to be retrieved
    var columnsToGet = "report_count, organization_count, district_id, district_title, adm0_code, adm1_code";

    var wc = {whereClause :"WHERE adm1_code = $1" };

    var sql = pg.featureCollectionSQL("summary_data_by_district", columnsToGet, wc);
    var preparedStatement = {
        name: "get_one_district_summary_data",
        text: sql,
        values:[]};

    pg.queryDeferred(preparedStatement, {sqlParams: [req.params.adm1_code]})
        .then(function(result){
            var results = result[0].response.features;

            if (results) {
                res.send(JSON.stringify(results));
            }
            else {
                res.send(JSON.stringify({status:"error", msg:"District summary does not exist"}));
            }
        })
        .catch(function(err){
            next(err);
        });
});






module.exports = router;



