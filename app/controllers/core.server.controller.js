'use strict';

var gravatar = require('gravatar');

/**
 * Module dependencies.
 */
exports.index = function(req, res) {
	if(req.user) {
		req.user.gravatar = 'http:' + gravatar.url(req.user.email, {s: 50});
	}
	res.render('index', {
		user: req.user || null
	});
};