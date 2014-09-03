'use strict';

module.exports = function(app) {

	var users = require('../../app/controllers/users');

	// User Routes
	var skills = require('../../app/controllers/skills');

	app.route('/skills/merge').post(users.requiresLogin, skills.merge);

	app.route('/skills/delete').post(users.requiresLogin, skills.deleteSkill);

	app.route('/skills/orphans').get(users.requiresLogin, skills.orphans);

	app.route('/skills').get(users.requiresLogin, skills.all);

};
