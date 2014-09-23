'use strict';

module.exports = {
	db: process.env.MONGOHQ_URL || 'mongodb://localhost/xskillz-dev',
	app: {
		title: 'xskillz - Xebia France'
	},
	google: {
		clientID: process.env.GOOGLE_ID || 'APP_ID',
		clientSecret: process.env.GOOGLE_SECRET || 'APP_SECRET',
		callbackURL: 'http://xskillz.xebia.fr/auth/google/callback',
		api: {
			clientID: process.env.GOOGLE_API_ID || 'APP_ID',
			clientSecret: process.env.GOOGLE_API_SECRET || 'APP_SECRET',
			callbackURL: 'http://xskillz.xebia.fr/admin/gapi/auth/callback'
		}
	}
};
