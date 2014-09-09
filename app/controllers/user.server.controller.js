'use strict';


var http = require('superagent'),
  _ = require('lodash'),
  Q = require('q'),
  xskillzNeo4j = require('../models/xskillz.neo4j');

/**
 * Module dependencies.
 */
exports.profile = function(req, res) {
  var email = req.params.email;

  xskillzNeo4j.findXebianByEmail(email)
    .then(function(results){
      console.log(results);
      res.jsonp(results); 
    });
};

exports.skillz = function(req, res) {
  var email = req.params.email;

  var skillz = xskillzNeo4j.findXebianSkillz(email);

  skillz.then(function(result) {
    res.jsonp(result || []);
  });
};