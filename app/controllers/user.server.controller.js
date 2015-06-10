'use strict';


var http = require('superagent'),
    _ = require('lodash'),
    Q = require('q'),
    xskillzNeo4j = require('../models/xskillz.neo4j'),
    gravatar = require('gravatar');

/**
 * Module dependencies.
 */
exports.profile = function (req, res) {
    var email = req.params.email;

    xskillzNeo4j.findXebianByEmail(email)
        .then(function (results) {
            var user = results[0][0].data;
            if (results[0][1]) {
                user.manager = results[0][1].data;
            }
            user.gravatar = 'http:' + gravatar.url(user.email, {s: 50});
            res.jsonp(user);
        });
};

exports.skillz = function (req, res) {
    var email = req.params.email;

    var skillz = xskillzNeo4j.findXebianSkillz(email);

    skillz.then(function (result) {
        res.jsonp(result || []);
    });
};

exports.remove = function (req, res) {
    var formerXebianMail = req.params.email;
    var currentUser = req.user;
    console.log('Deleting xebian: ' + formerXebianMail + ' by: ' + currentUser.email);

    if (formerXebianMail === currentUser.email || _.contains(currentUser.roles, 'MANAGER') || _.contains(currentUser.roles, 'COMMERCE')) {
        console.log('Authorized operation');
        xskillzNeo4j.removeXebianByMail(formerXebianMail);
        res.jsonp('DONE' || []);

    } else {
        console.log('Well tried ' + currentUser.displayName);
        res.jsonp(':p' || []);

    }
};