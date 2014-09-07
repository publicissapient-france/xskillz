'use strict';

/**
 * Module dependencies.
 */
var _ = require('lodash'),
	xskillzNeo4J = require('../models/xskillz.neo4j');


exports.mySkillz = function(req, res){
	var user = req.user;

	var skillz = xskillzNeo4J.findXebianSkillz(user.email);

	skillz.then(function(result) {
  		res.jsonp(result || []);
  	});

};

exports.findXebiansBySkillz = function(req,res){
	xskillzNeo4J.findXebiansBySkillz(req.query.q)
		.then(function(results){
			res.jsonp(results);	
		});
};

exports.allXebians = function(req,res){
	xskillzNeo4J.findXebiansByName(req.query.q)
		.then(function(results){
			res.jsonp(results);	
		});
};

exports.disassociate = function(req, res){
	xskillzNeo4J.deleteElement(req.body.relationship)
		.then(function(result){
			res.redirect(303, '/users/me/skillz');
		});
};

exports.availableSkillzForMe = function(req, res){
	var skillQuery = req.query.q || '.';
	var user = req.user;

	console.log('query',skillQuery);

	var skillz = xskillzNeo4J.findAvailableSkillzForXebian(user.email, skillQuery);

	skillz.then(function(result) {
  		res.jsonp(result || []);
  	});
};

exports.associate = function(req, res) {
	var skill = req.body.skill;
	var relation_properties = req.body.relation_properties;
	var user = req.user;

	var findUser = function(){
		return xskillzNeo4J.findXebian(user.email);
	};


	var handleError = function(err) {
		return res.send(400, {
			message: err
		});
	};

	var associateSkillToUser = function(userNodeUrl, skillNodeUrl) {
		xskillzNeo4J.associateSkillToUser(userNodeUrl,skillNodeUrl, relation_properties)
			.then(function(relationshipUrl) {
				console.log('Created relationship', relationshipUrl);
				
				res.redirect(303, '/users/me/skillz');
			})
			.fail(function(err) {
				handleError(err);
			});
	};

	var manageNodeSkill = function() {
		findUser().then(function(userNode){
			if(userNode){
				var userNodeUrl = userNode[0][0].self;
				
				xskillzNeo4J.getSkill(skill.name).then(function(result) {
					if (!result) {

						xskillzNeo4J.createSkill(skill).then(function(skillNodeUrl) {
							associateSkillToUser(userNodeUrl, skillNodeUrl);
						})
						.fail(function(err) {
							handleError(err);
						});
					} else {
						var skillNodeUrl = result[0][0].self;
						associateSkillToUser(userNodeUrl, skillNodeUrl);
					}
				})
			.fail(function(err) {
				handleError(err);
			});
			}
		}).fail(function(err){
			handleError(err);
		});
	};

	manageNodeSkill();

};
