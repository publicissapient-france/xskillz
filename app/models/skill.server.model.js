'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

/**
 * Skill Schema
 */
var SkillSchema = new Schema({
	name: {
		type: String,
		default: '',
		required: 'Please fill Skill name',
		trim: true
	},
	created: {
		type: Date,
		default: Date.now
	},
	user: {
		type: Schema.ObjectId,
		ref: 'User'
	}
});

mongoose.model('Skill', SkillSchema);