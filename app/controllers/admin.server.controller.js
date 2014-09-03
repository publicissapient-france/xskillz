'use strict';

var util = require('util');
var _ = require('underscore');

var googleapis = require('googleapis');
var directory = googleapis.admin('directory_v1');


var oauth2Client = new googleapis.auth.OAuth2(
	'407785855930-cde7hoia0q9j6192195ji0no78j0p0h0.apps.googleusercontent.com',
	'gFBGoi21pO9XI4hOA5KeZbpE',
	'http://localhost:3000/admin/gapi/auth/callback'
);


exports.auth = function(req, res) {
	// generate consent page url
	var url = oauth2Client.generateAuthUrl({
		access_type: 'offline', // will return a refresh token
		scope: [
			"https://www.googleapis.com/auth/admin.directory.user",
			"https://www.googleapis.com/auth/admin.directory.user.readonly"
		]
	});

	res.redirect(url);
};

exports.authCallback = function(req, res) {
	oauth2Client.getToken(req.query.code, function(err, tokens) {
		oauth2Client.setCredentials(tokens);
		res.render('admin')
	});
};

exports.importContacts = function(req, res) {
	directory.users.list({ domain: 'xebia.fr', auth: oauth2Client }, function(err, data) {

		console.log("Users:", JSON.stringify(data, undefined, 2));

		var neo4jUsers = _(data.users).map(function(user) {
			return {
				email: user.primaryEmail,
				firstName: user.name.givenName,
				familyName:  user.name.familyName,
				photoUrl:  user.thumbnailPhotoUrl
			};
		});

		console.log("Users:", JSON.stringify(neo4jUsers, undefined, 2));

		res.render('import', {
			user: req.user || null,
			error: err,
			users: data
		});
	});
};
