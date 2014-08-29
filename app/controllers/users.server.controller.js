'use strict';

/**
 * Module dependencies.
 */
var passport = require('passport'),
	User = require('../models/user.server.model.js'),
	_ = require('lodash'),
	xskillzNeo4J = require('../models/xskillz.neo4j');

/**
 * Update user details
 */
exports.update = function(req, res) {
	// Init Variables
	var user = req.user;
	var message = null;

	// For security measurement we remove the roles from the req.body object
	delete req.body.roles;

	if (user) {
		// Merge existing user
		user = _.extend(user, req.body);
		user.updated = Date.now();
		user.displayName = user.firstName + ' ' + user.lastName;

		user.save(function(err) {
			if (err) {
				return res.send(400, {
					message: getErrorMessage(err)
				});
			} else {
				req.login(user, function(err) {
					if (err) {
						res.send(400, err);
					} else {
						res.jsonp(user);
					}
				});
			}
		});
	} else {
		res.send(400, {
			message: 'User is not signed in'
		});
	}
};

/**
* Update user details
*/
exports.delete = function(req, res) {
	// Init Variables
	var user = req.user;
	var message = null;

	// For security measurement we remove the roles from the req.body object
	delete req.body.roles;

	if (user) {
		user.remove(function(err) {
			if (err) {
				return res.send(400, {
					message: getErrorMessage(err)
				});
			} else {
				req.logout();
				res.send(200);
			}
		});
	} else {
		res.send(400, {
			message: 'User is not signed in'
		});
	}
};

/**
 * Signout
 */
exports.signout = function(req, res) {
	req.logout();
	res.redirect('/');
};

/**
 * Send User
 */
exports.me = function(req, res) {
	res.jsonp(req.user || null);
};

/**
 * OAuth callback
 */
exports.oauthCallback = function(strategy) {
	return function(req, res, next) {
		passport.authenticate(strategy, function(err, user, redirectURL) {
			if (err || !user) {
				return res.redirect('/#!/signin');
			}
			req.login(user, function(err) {
				if (err) {
					return res.redirect('/#!/signin');
				}

				return res.redirect(redirectURL || '/');
			});
		})(req, res, next);
	};
};

/**
 * User middleware
 */
exports.userByID = function(req, res, next, id) {
  	xskillzNeo4J.findXebianById(id).then(next);
};


/**
 * Require login routing middleware
 */
exports.requiresLogin = function(req, res, next) {
	if (!req.isAuthenticated()) {
		return res.send(401, {
			message: 'User is not logged in'
		});
	}

	next();
};

/**
 * Helper function to save or update a OAuth user profile
 */
exports.saveOAuthUserProfile = function(req, providerUserProfile, done) {

	if (!req.user) {
		User.findOne(providerUserProfile.providerData.id).then(function(user){
				if (!user) {
					console.log('Welcome to new user',providerUserProfile.displayName);
					// And save the user		
					User.save(providerUserProfile,function(err) {
						return done(null, providerUserProfile);
					});
					
				} else {
					return done(null, user);
				}

		}).fail(function(err){
			done(err);
		});
	} else{
		return done(new Error('User is already connected using this provider'), providerUserProfile);
	}
};

/**
 * Remove OAuth provider
 */
exports.removeOAuthProvider = function(req, res, next) {
	var user = req.user;
	var provider = req.param('provider');

	if (user && provider) {
		// Delete the additional provider
		if (user.additionalProvidersData[provider]) {
			delete user.additionalProvidersData[provider];

			// Then tell mongoose that we've updated the additionalProvidersData field
			user.markModified('additionalProvidersData');
		}

		user.save(function(err) {
			if (err) {
				return res.send(400, {
					message: getErrorMessage(err)
				});
			} else {
				req.login(user, function(err) {
					if (err) {
						res.send(400, err);
					} else {
						res.jsonp(user);
					}
				});
			}
		});
	}
};

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

exports.disassociate = function(req, res){
	xskillzNeo4J.deleteElement(req.body.relationship)
		.then(function(result){
			res.redirect(303, '/users/me/skillz');
		});
};

exports.associate = function(req, res) {
	var skill = req.body.skill;
	var user = req.user;

	var findUser = function(){
		return xskillzNeo4J.findXebian(user.email);
	};


	var handleError = function(err) {
		return res.send(400, {
			message: getErrorMessage(err)
		});
	};

	var associateSkillToUser = function(userNodeUrl, skillNodeUrl) {
		xskillzNeo4J.associateSkillToUser(userNodeUrl,skillNodeUrl)
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
				
				xskillzNeo4J.findSkill(skill).then(function(result) {

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
