'use strict';

/**
 * Module dependencies.
 */
var _ = require('underscore');
var NEO4J = require('../models/neo4j.js');

exports.all = function (req, res) {

    var query = {
        'query': 'MATCH (s:' + NEO4J.SKILL_TYPE + ') OPTIONAL MATCH s<-[r:`HAS`]-() return s.name, count(r),id(s) order by upper(s.name)'
    };

    return NEO4J.findPromise(query, function (row) {
        return {'name': row[0], 'count': row[1], 'nodeId': row[2]};
    }).then(function (results) {
        if (results) {
            res.jsonp(results);
        } else {
            res.jsonp([]);
        }
    });
};

var deleteSkillNode = function(source){
    var removeOldSkillQuery = {
        'query': 'start oldSkill=node( {oldSkillId} )  OPTIONAL MATCH (oldSkill)-[r]-() DELETE oldSkill,r',
        'params': {
            'oldSkillId': source
        }
    };
    return NEO4J.execute(removeOldSkillQuery);
};


exports.merge = function (req, res) {
    var source = req.body.source;
    var destination = req.body.destination;

    var addNewRelationsQuery = {
        'query': 'START oldSkill=node( {oldSkillId} ), newSkill=node( {newSkillId} ) match  (x: `' + NEO4J.XEBIAN_TYPE + '`)-[oldRelation:`' + NEO4J.SKILLZ_RELATION + '`]->oldSkill WHERE NOT (x)-[:`' + NEO4J.SKILLZ_RELATION + '`]->newSkill  create (x)-[r:`' + NEO4J.SKILLZ_RELATION + '` {level: oldRelation.level, like: oldRelation.like }]->(newSkill)',
        'params': {
            'oldSkillId': source,
            'newSkillId': destination
        }
    };

    var addNewRelations = NEO4J.execute(addNewRelationsQuery);

    return addNewRelations
        .then(function () {
            return deleteSkillNode(source);
        })
        .then(function (){
            res.redirect(303, '/skills/');
        });

};

exports.deleteSkill = function (req, res) {
    var source = req.body.source;

    return deleteSkillNode(source).then(function () {
        res.redirect(303, '/skills/orphans');
    });

};

exports.orphans = function (req, res) {
    var query = {
        'query': 'match (orphan:SKILL) where not ()-[:HAS]->(orphan) return orphan.name, id(orphan) order by upper(orphan.name)'
    };

    return NEO4J.findPromise(query, function (row) {
        return {'name': row[0], 'nodeId': row[1]};
    }).then(function (results) {
        if (results) {
            res.jsonp(results);
        } else {
            res.jsonp([]);
        }
    });
};