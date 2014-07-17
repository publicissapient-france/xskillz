'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Skill = mongoose.model('Skill'),
	_ = require('lodash');

/**
 * Get the error message from error object
 */
var getErrorMessage = function(err) {
	var message = '';

	if (err.code) {
		switch (err.code) {
			case 11000:
			case 11001:
				message = 'Skill already exists';
				break;
			default:
				message = 'Something went wrong';
		}
	} else {
		for (var errName in err.errors) {
			if (err.errors[errName].message) message = err.errors[errName].message;
		}
	}

	return message;
};

/**
 * Create a Skill
 */
exports.create = function(req, res) {
	var skill = new Skill(req.body);
	skill.user = req.user;

	skill.save(function(err) {
		if (err) {
			return res.send(400, {
				message: getErrorMessage(err)
			});
		} else {
			res.jsonp(skill);
		}
	});
};

/**
 * Show the current Skill
 */
exports.read = function(req, res) {
	res.jsonp(req.skill);
};

/**
 * Update a Skill
 */
exports.update = function(req, res) {
	var skill = req.skill ;

	skill = _.extend(skill , req.body);

	skill.save(function(err) {
		if (err) {
			return res.send(400, {
				message: getErrorMessage(err)
			});
		} else {
			res.jsonp(skill);
		}
	});
};

/**
 * Delete an Skill
 */
exports.delete = function(req, res) {
	var skill = req.skill ;

	skill.remove(function(err) {
		if (err) {
			return res.send(400, {
				message: getErrorMessage(err)
			});
		} else {
			res.jsonp(skill);
		}
	});
};

/**
 * List of Skills
 */
exports.list = function(req, res) { Skill.find().sort('-created').populate('user', 'displayName').exec(function(err, skills) {
		if (err) {
			return res.send(400, {
				message: getErrorMessage(err)
			});
		} else {
			res.jsonp(skills);
		}
	});
};

/**
 * Skill middleware
 */
exports.skillByID = function(req, res, next, id) { Skill.findById(id).populate('user', 'displayName').exec(function(err, skill) {
		if (err) return next(err);
		if (! skill) return next(new Error('Failed to load Skill ' + id));
		req.skill = skill ;
		next();
	});
};

/**
 * Skill authorization middleware
 */
exports.hasAuthorization = function(req, res, next) {
	if (req.skill.user.id !== req.user.id) {
		return res.send(403, 'User is not authorized');
	}
	next();
};

exports.affect = function(req, res) {
	
};