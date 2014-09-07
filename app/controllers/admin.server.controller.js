'use strict';

var util = require('util');
var _ = require('underscore');
var async = require('async');
var request = require('request');
var xskillzNeo4J = require('../models/xskillz.neo4j');

var googleapis = require('googleapis');
var directory = googleapis.admin('directory_v1');

var User = require('../models/user');

var config = require('../../config/config');


var oauth2Client = new googleapis.auth.OAuth2(
	config.google.api.clientID,
	config.google.api.clientSecret,
	config.google.api.callbackURL
);

exports.auth = function(req, res) {
	// generate consent page url
	var url = oauth2Client.generateAuthUrl({
		access_type: 'offline', // will return a refresh token
		scope: [
			'https://www.googleapis.com/auth/admin.directory.user',
			'https://www.googleapis.com/auth/admin.directory.user.readonly'
		]
	});

	res.redirect(url);
};

exports.authCallback = function(req, res) {
	oauth2Client.getToken(req.query.code, function(err, tokens) {
		oauth2Client.setCredentials(tokens);
		res.render('admin');
	});
};

exports.importContacts = function(req, res) {
	if (oauth2Client.credentials === undefined || oauth2Client.credentials.access_token === undefined) {
		res.redirect('/admin/gapi/auth');
	}
	else {
		directory.users.list({ domain: 'xebia.fr', maxResults: 200, auth: oauth2Client }, function(err, data) {

			console.log('Users:', JSON.stringify(data, undefined, 2));

			var neo4jUsers = _(data.users).map(function(user) {
				return {
					username: user.primaryEmail,
					email: user.primaryEmail,
					firstName: user.name.givenName,
					lastName:  user.name.familyName,
					picture:  user.thumbnailPhotoUrl
				};
			});

			var saveUser = function(user, cb) {
				User.importUserWithDomainDirectoryData(user, cb);
			};

			console.log('Users:', JSON.stringify(neo4jUsers, undefined, 2));

			async.each(neo4jUsers, saveUser, function(err, data) {
				console.log(err || data);

				res.render('import', {
					user: req.user || null,
					error: err,
					users: data
				});
			});

		});
	}
};


var associateSkillToUser = function (userEmail, skillName, cb) {
	var relation_properties = { level: 0, like: false };

	var associateSkillToUser = function(userNodeUrl, skillNodeUrl, cb) {

		xskillzNeo4J.userHasSkill(userNodeUrl, skillNodeUrl)
		.then(function(user) {
			if (!user) {
				xskillzNeo4J.associateSkillToUser(userNodeUrl, skillNodeUrl, relation_properties)
				.then(function(relationshipUrl) {
					console.log('Created relationship', relationshipUrl);
					cb();
				})
				.fail(function(err) {
					cb(err);
				});
			}
			else {
				cb();
			}
		})
		.fail(function (err) {
			cb(err);
		});
	};

	xskillzNeo4J.findXebian(userEmail)
		.then(function (userNode) {
			if (userNode) {
				var userNodeUrl = userNode[0][0].self;

				xskillzNeo4J.getSkill(skillName)
					.then(function (result) {
						if (!result) {
							xskillzNeo4J.createSkill({ name: skillName })
								.then(function (skillNodeUrl) {
									associateSkillToUser(userNodeUrl, skillNodeUrl, cb);
								})
								.fail(function (err) {
									cb(err);
								});
						} else {
							var skillNodeUrl = result[0][0].self;
							associateSkillToUser(userNodeUrl, skillNodeUrl, cb);
						}
					})
					.fail(function (err) {
						cb(err);
					});
			}
			else {
				cb();
			}
		})
		.fail(function (err) {
			cb(err);
		});
};

exports.importSkills = function(req, res) {

	request.get({ url: 'http://backend.mobile.xebia.io/api/v1/blog/posts/recent?limit=100', json: true}, function(error, response, body) {
		if (error) {
			res.json(500, error);
		}
		else {

			var saveSkillForUser = function(userEmail) {
				return function(tag, cb) {
					associateSkillToUser(userEmail, tag.title, cb);
				};
			};

			var saveSkillsForPost = function(post, cb) {
				var username = post.authors[0].nickname.toLowerCase();
				var userEmail  = username + '@xebia.fr';
				async.each(post.tags, saveSkillForUser(userEmail), cb);
			};

			async.each(body.posts, saveSkillsForPost, function(err, data) {
				console.log(err || data);

				res.render('import', {
					user: req.user || null,
					error: err,
					users: data
				});
			});
		}
	});
};


