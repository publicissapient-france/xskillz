'use strict';

/**
 * Module dependencies.
 */
var passport = require('passport');

module.exports = function(app) {
	// User Routes
	var auth = require('../../app/controllers/auth');

	app.route('/users/me').get(auth.me);
	app.route('/users').delete(auth.delete);
	app.route('/users').put(auth.update);

	// Setting the google oauth routes
	app.route('/auth/google').get(passport.authenticate('google', {
		scope: [
			'https://www.googleapis.com/auth/userinfo.profile',
			'https://www.googleapis.com/auth/userinfo.email'
		]
	}));
	app.route('/auth/google/callback').get(auth.oauthCallback('google'));

	app.route('/auth/signout').get(auth.signout);

	// Finish by binding the user middleware
	app.param('userId', auth.userByID);
};
