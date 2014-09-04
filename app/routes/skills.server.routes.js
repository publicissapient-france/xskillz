'use strict';

module.exports = function(app) {

	var auth = require('../../app/controllers/auth');

	// User Routes
	var skills = require('../../app/controllers/skills');

	app.route('/skills/merge').post(auth.requiresLogin, skills.merge);

	app.route('/skills/delete').post(auth.requiresLogin, skills.deleteSkill);

	app.route('/skills/orphans').get(auth.requiresLogin, skills.orphans);

	app.route('/skills').get(auth.requiresLogin, skills.all);

};
