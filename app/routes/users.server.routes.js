'use strict';

/**
 * Module dependencies.
 */
var passport = require('passport');

module.exports = function(app) {
	// User Routes
	var users = require('../../app/controllers/users'),
		user = require('../../app/controllers/user'),
		auth = require('../../app/controllers/auth');


	app.route('/users/me/skillz').get(auth.requiresLogin,users.mySkillz);

	app.route('/users/me/availableSkillz').get(auth.requiresLogin, users.availableSkillzForMe);

	app.route('/users').get(auth.requiresLogin, users.allXebians);

	app.route('/users/me/skillz')
		.put(auth.requiresLogin, users.associate);
		
	app.route('/users/me/skillz/disassociate')
		.post(auth.requiresLogin, users.disassociate);

	app.route('/skillz')
		.get(auth.requiresLogin, users.findXebiansBySkillz);

	app.route('/user/:email').get(user.profile);

	app.route('/user/skillz/:email').get(user.skillz);

};
