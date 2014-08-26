'use strict';

/**
 * Module dependencies.
 */
var passport = require('passport');

module.exports = function(app) {
	// User Routes
	var users = require('../../app/controllers/users');
	app.route('/users/me/skillz').get(users.mySkillz);
	app.route('/users/me').get(users.me);
	app.route('/users').delete(users.delete);
	app.route('/users').put(users.update);

	app.route('/users/me/skillz')
		.put(users.requiresLogin, users.associate);

	// Setting up the users api
	app.route('/auth/signin').post(users.signin);
	app.route('/auth/signout').get(users.signout);

	// Setting the google oauth routes
	app.route('/auth/google').get(passport.authenticate('google', {
		scope: [
			'https://www.googleapis.com/auth/userinfo.profile',
			'https://www.googleapis.com/auth/userinfo.email'
		]
	}));
	app.route('/auth/google/callback').get(users.oauthCallback('google'));

	// Setting the linkedin oauth routes
	app.route('/auth/linkedin').get(passport.authenticate('linkedin'));
	app.route('/auth/linkedin/callback').get(users.oauthCallback('linkedin'));

	// Finish by binding the user middleware
	app.param('userId', users.userByID);
};
