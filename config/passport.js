'use strict';

var passport = require('passport'),
	User = require('../app/models/user.server.model.js'),
	path = require('path'),
	config = require('./config');

module.exports = function() {
	// Serialize sessions
	passport.serializeUser(function(user, done) {
		done(null, user._id);
	});

	// Deserialize sessions
	passport.deserializeUser(function(id, done) {
		User.findOne(id).then(function(user){
			done(null, user);
		}).fail(function(err){
			done(err);
		});
	});

	// Initialize strategies
	config.getGlobbedFiles('./config/strategies/**/*.js').forEach(function(strategy) {
		require(path.resolve(strategy))();
	});
};