'use strict';

/**
 * Module dependencies.
 */
var xskillzNeo4J = require('../models/xskillz.neo4j');
var _ = require('underscore');

exports.all = function(req,res){
	xskillzNeo4J.allSkillz().then(function(results) {
		if(results){
			res.jsonp(results);	
		}else{
			res.jsonp([]);	
		}
	});
};

exports.merge = function(req,res){
	var source = req.body.source;
	var destination = req.body.destination;

	return xskillzNeo4J.mergeSkill(source,destination).then(function(){
		res.redirect(303, '/skills');
	});
};

exports.deleteSkill = function(req,res){
	var source = req.body.source;

	return xskillzNeo4J.deleteSkill(source).then(function(){
		res.redirect(303, '/skills/orphans');
	});
};

exports.orphans = function(req,res){
	xskillzNeo4J.orphanSkillz().then(function(results){
		if(results){
			res.jsonp(results);	
		}else{
			res.jsonp([]);	
		}
	});
};