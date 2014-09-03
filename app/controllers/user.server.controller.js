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

  xskillzNeo4j.findXebian(email)
    .then(function(results){
      console.log(results);
      res.jsonp(results); 
    });
};