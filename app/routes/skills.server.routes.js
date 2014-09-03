'use strict';

module.exports = function(app) {
	// User Routes
	var skills = require('../../app/controllers/skills');

	app.route('/skills').get(skills.all);

};
