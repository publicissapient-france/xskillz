'use strict';

/**
 * Module dependencies.
 */
var xskillzNeo4J = require('../models/xskillz.neo4j');
var _ = require('underscore');
var NEO4J = require('../models/neo4j');

exports.all = function(req,res){

  var query = {
    'query': 'MATCH (s:' + NEO4J.SKILL_TYPE + ') OPTIONAL MATCH s<-[r:`HAS`]-() return s.name, count(r),id(s) order by upper(s.name)'
  };
  
  NEO4J.findPromise(query, function(row){
      return {'name':row[0], 'count': row[1], 'nodeId': row[2]};
  }).then(function(results) {
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
	  var query = {
	    'query': 'match (orphan:SKILL) where not ()-[:HAS]->(orphan) return orphan.name, id(orphan) order by upper(orphan.name)'
	  };

	  NEO4J.findPromise(query,function(row){
	    return {'name': row[0],'nodeId': row[1]};
	  }).then(function(results){
		if(results){
			res.jsonp(results);	
		}else{
			res.jsonp([]);	
		}
	});
};