'use strict';

module.exports = function(app) {

	var users = require('../../app/controllers/users');

	// User Routes
	var skills = require('../../app/controllers/skills');

	app.route('/skills/deduplicate').post(users.requiresLogin, skills.deduplicate);

	app.route('/skills').get(users.requiresLogin, skills.all);


};
