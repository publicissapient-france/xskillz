'use strict';

/**
 * Module dependencies.
 */
var xskillzNeo4J = require('../models/xskillz.neo4j');

exports.all = function(req,res){
	xskillzNeo4J.findAllSkills().then(function(result) {
		res.jsonp(result);	
	});
	
};
