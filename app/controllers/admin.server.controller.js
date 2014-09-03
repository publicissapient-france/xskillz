'use strict';

var util = require('util');
var _ = require('underscore');
var async = require('async');

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
	if (oauth2Client.credentials == undefined || oauth2Client.credentials.access_token == undefined) {
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
