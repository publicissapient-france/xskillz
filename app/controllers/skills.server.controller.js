'use strict';

/**
 * Module dependencies.
 */
var xskillzNeo4J = require('../models/xskillz.neo4j');
var _ = require('underscore');

exports.all = function(req,res){
	xskillzNeo4J.findAllSkills().then(function(result) {
		result = _(result).filter(function(r) {
			return r[1] > 0;
		});

		res.jsonp(result);	
	});
	
};

exports.deduplicate = function(req,res){

	var source = req.body.source;
	var destination = req.body.destination;

	xskillzNeo4J.deduplicate(source,destination);
};
