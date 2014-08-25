'use strict';

module.exports = {
	db: 'mongodb://localhost/xskillz-dev',
	app: {
		title: 'xskillz - Development Environment'
	},
	google: {
		clientID: process.env.GOOGLE_ID || 'APP_ID',
		clientSecret: process.env.GOOGLE_SECRET || 'APP_SECRET',
		callbackURL: 'http://localhost:3000/auth/google/callback'
	}
};