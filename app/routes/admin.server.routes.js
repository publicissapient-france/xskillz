'use strict';

module.exports = function(app) {
	// Root routing
	var admin = require('../../app/controllers/admin');
	app.route('/admin/gapi/auth').get(admin.auth);
	app.route('/admin/gapi/auth/callback').get(admin.authCallback);
	app.route('/admin/gapi/contacts/import').get(admin.importContacts);
	app.route('/admin/skills/import').get(admin.importSkills);
};