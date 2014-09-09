'use strict';

/**
 * Module dependencies.
 */
var _ = require('lodash'),
    xskillzNeo4J = require('../models/xskillz.neo4j'),
    NEO4J = require('../models/neo4j.js');


exports.mySkillz = function (req, res) {
    var user = req.user;

    var skillz = xskillzNeo4J.findXebianSkillz(user.email);

    skillz.then(function (result) {
        res.jsonp(result || []);
    });

};


exports.findXebiansBySkillz = function (req, res) {
    var skillName = req.query.q;
    var query = {
        'query': 'MATCH (x: ' + NEO4J.XEBIAN_TYPE + ')-[r:`' + NEO4J.SKILLZ_RELATION + '`]->s WHERE s.name=~ {q} RETURN x.displayName, x.email, x.picture, r.level, r.like, s.name',
        'params': {
            'q': '(?i).*' + skillName + '.*'
        }
    };
    NEO4J.findPromise(query, function (row) {
        return {'xebianName': row[0], 'email': row[1], 'picture': row[2], 'level': row[3], 'like': row[4], 'skillName': row[5]};
    }).then(function (result) {
        res.jsonp(result);
    });
};


exports.allXebians = function (req, res) {
    var query = {
        'query': 'MATCH (x: ' + NEO4J.XEBIAN_TYPE + ') WHERE x.displayName =~ {q} RETURN x.displayName, x.email, x.picture',
        'params': {
            'q': '(?i).*' + req.query.q + '.*'
        }
    };

    return NEO4J.findPromise(query, function (row) {
        return {'displayName': row[0], 'email': row[1], 'picture': row[2]};
    }).then(function (results) {
        res.jsonp(results);
    });
};

exports.disassociate = function (req, res) {
    var relationId = req.body.relationId;

    var query = {
        'query': 'start r=relationship({relationId}) delete r',
        'params': {
            'relationId': relationId
        }
    };

    return NEO4J.execute(query).then(function () {
        res.redirect(303, '/users/me/skillz');
    });
};

exports.availableSkillzForMe = function (req, res) {
    var skillQuery = req.query.q || '.';
    var user = req.user;
    var email = user.email;

    var query = {
        'query': 'MATCH (xebian: ' + NEO4J.XEBIAN_TYPE + '), (skill: ' + NEO4J.SKILL_TYPE + ' ) ' +
            'WHERE skill.name =~ {skillQuery} and xebian.email = {email} and not (xebian) -[:HAS]-> (skill) ' +
            'RETURN skill.name order by upper(skill.name)',
        'params': {
            'email': email,
            'skillQuery': '(?i).*' + skillQuery + '.*'
        }
    };
    NEO4J.findPromise(query, function (row) {
        return {'name': row[0]};
    }).then(function (result) {
        res.jsonp(result || []);
    });

};

exports.updateLike = function (req, res) {
    var skillId = req.params.id;
    var value = req.body.like;

    var query = {
        'query': 'start r=relationship({skillId}) set r.like = {newValue}',
        'params': {
            'skillId'  : Number(skillId),
            'newValue' : value
        }
    };

    NEO4J.execute(query).then(function(){
        res.redirect(303, '/users/me/skillz');
    });
};

exports.updateLevel = function (req, res) {
    var skillId = req.params.id;
    var value = req.body.level;

    var query = {
        'query': 'start r=relationship({skillId}) set r.level = {newValue}',
        'params': {
            'skillId'  : Number(skillId),
            'newValue' : value
        }
    };

    NEO4J.execute(query).then(function(){
        res.redirect(303, '/users/me/skillz');
    });
};

exports.associate = function (req, res) {
    var skill = req.body.skill;
    var relation_properties = req.body.relation_properties;
    var user = req.user;

    var findUser = function () {
        return xskillzNeo4J.findXebianByEmail(user.email);
    };


    var handleError = function (err) {
        return res.send(400, {
            message: err
        });
    };

    var associateSkillToUser = function (userNodeUrl, skillNodeUrl) {
        xskillzNeo4J.associateSkillToUser(userNodeUrl, skillNodeUrl, relation_properties)
            .then(function (relationshipUrl) {
                console.log('Created relationship', relationshipUrl);

                res.redirect(303, '/users/me/skillz');
            })
            .fail(function (err) {
                handleError(err);
            });
    };

    var manageNodeSkill = function () {
        findUser().then(function (userNode) {
            if (userNode) {
                var userNodeUrl = userNode[0][0].self;

                xskillzNeo4J.getSkill(skill.name).then(function (result) {

                    if (result.length === 0) {

                        xskillzNeo4J.createSkill(skill).then(function (skillNodeUrl) {
                            associateSkillToUser(userNodeUrl, skillNodeUrl);
                        })
                            .fail(function (err) {
                                handleError(err);
                            });
                    } else {
                        var skillNodeUrl = result[0][0].self;
                        associateSkillToUser(userNodeUrl, skillNodeUrl);
                    }
                })
                    .fail(function (err) {
                        handleError(err);
                    });
            }
        }).fail(function (err) {
            handleError(err);
        });
    };

    manageNodeSkill();

};
