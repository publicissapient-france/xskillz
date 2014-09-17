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
          var user = results[0][0].data;
          if(results[0][1]){
              user.manager = results[0][1].data;
          }
          res.jsonp(user);
    });
};

exports.skillz = function(req, res) {
  var email = req.params.email;

  var skillz = xskillzNeo4j.findXebianSkillz(email);

  skillz.then(function(result) {
    res.jsonp(result || []);
  });
};