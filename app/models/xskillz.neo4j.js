'use strict';

var http = require('superagent'),
    _ = require('lodash'),
    Q = require('q'),
    NEO4J = require('./neo4j');

var XEBIAN_TYPE = NEO4J.XEBIAN_TYPE;
var SKILL_TYPE = NEO4J.SKILL_TYPE;
var SKILLZ_RELATION = NEO4J.SKILLZ_RELATION;
var MANAGER_RELATION = NEO4J.SKILLZ_RELATION;

exports.createXebian = function (userData) {
    return NEO4J.createNodePromise(XEBIAN_TYPE, userData);
};

exports.updateXebian = function (userData) {
    return NEO4J.updateNodePromise(XEBIAN_TYPE, 'email', userData.email, userData);
};

exports.createSkill = function (skill) {
    return NEO4J.createNodePromise(SKILL_TYPE, skill);
};

exports.findXebianById = function (id) {
    var query = {
        'query': 'MATCH (n: ' + XEBIAN_TYPE + ') WHERE n._id = {_id} RETURN n,labels(n)',
        'params': {
            '_id': id
        }
    };
    return NEO4J.findPromise(query);
};

exports.findXebianByEmail = function (email) {
    var query = {
        'query': 'MATCH (n: ' + XEBIAN_TYPE + ') WHERE n.email = {email} OPTIONAL MATCH (n)<-[:IS_MANAGER_OF]-(manager) RETURN n,manager',
        'params': {
            'email': email
        }
    };
    return NEO4J.findPromise(query);
};

exports.findXebianSkillz = function (email) {
    var query = {
        'query': 'MATCH (n: ' + XEBIAN_TYPE + ')-[r:`' + SKILLZ_RELATION + '`]->s ' +
        'WHERE n.email = {email} ' +
        'RETURN s.name, r.level, r.like, id(r), s.domains  order by r.like DESC, r.level DESC, s.name',
        'params': {
            'email': email
        }
    };

    return NEO4J.findPromise(query, function (row) {
        return {'name': row[0], 'level': row[1], 'like': row[2], 'relationId': row[3], 'domains': row[4]};
    });
};

exports.removeXebianByMail = function (email) {
    var query = {
        'query': 'MATCH (x:' + XEBIAN_TYPE + ') WHERE x.email={email} ' +
        'OPTIONAL MATCH x-[r]-(s) ' +
        'DELETE r,x',
        'params': {
            'email': email
        }
    };
    return NEO4J.findPromise(query);
};

exports.getSkill = function(skillName) {
    var query = {
        'query': 'MATCH (n: '+SKILL_TYPE+' ) WHERE n.name= {name} RETURN n',
        'params': {
            'name': skillName
        }
    };
    return NEO4J.findPromise(query);
};

exports.associateSkillToUser = function (userNodeUrl, skillNodeUrl, relation_properties) {
    var securedURL = NEO4J.makeURLSecured(userNodeUrl);
    relation_properties.created = new Date();

    var deferred = Q.defer();
    http
        .post(securedURL + '/relationships')
        .set('Accept', 'application/json; charset=UTF-8')
        .set('Content-Type', 'application/json')
        .send({
            'to': skillNodeUrl,
            'type': SKILLZ_RELATION,
            'data': relation_properties
        })
        .end(function (err, res) {
            if (err) {
                deferred.reject(err);
            } else {
                console.log('associateSkillToUser', res.statusCode);
                deferred.resolve(res.body.self);
            }
        });
    return deferred.promise;
};