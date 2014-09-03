'use strict';

module.exports = {
	db: 'mongodb://localhost/xskillz-test',
	port: 3001,
	app: {
		title: 'xskillz - Test Environment'
	},
	google: {
		clientID: process.env.GOOGLE_ID || 'APP_ID',
		clientSecret: process.env.GOOGLE_SECRET || 'APP_SECRET',
		callbackURL: 'http://localhost:3000/auth/google/callback',
		api: {
			clientID: process.env.GOOGLE_API_ID || 'APP_ID',
			clientSecret: process.env.GOOGLE_API_SECRET || 'APP_SECRET',
			callbackURL: 'http://localhost:3000/admin/gapi/auth/callback'
		}
	}
};
