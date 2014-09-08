'use strict';

var http = require('superagent'),
  _ = require('lodash'),
  Q = require('q'),
  NEO4J = require('./neo4j');

var XEBIAN_TYPE = 'XEBIAN';
var SKILL_TYPE = 'SKILL';

var SKILLZ_RELATION = 'HAS';


exports.createXebian = function(userData) {
	return NEO4J.createNodePromise(XEBIAN_TYPE, userData);
};

exports.updateXebian = function(userData) {
	return NEO4J.updateNodePromise(XEBIAN_TYPE, 'email', userData.email, userData);
};

exports.createSkill = function(skill) {
  return NEO4J.createNodePromise(SKILL_TYPE, skill);
};

exports.deleteElement = function(elementURL) {
  var securedURL = NEO4J.makeURLSecured(elementURL);

  var deferred = Q.defer();
  http
    .del(securedURL)
    .end(function(res){
      console.log('deleted : ' + securedURL + ' with status ' + res.statusCode);
      deferred.resolve(res);
  });
  return deferred.promise;
};

exports.findXebian = function(email) {
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+') WHERE n.email = {email} RETURN n',
    'params' : {
      'email': email
    }
  };
  return NEO4J.findPromise(query);
};

exports.findXebianById = function(id) {
	var query = {
		'query' : 'MATCH (n: '+XEBIAN_TYPE+') WHERE n._id = {_id} RETURN n',
		'params' : {
			'_id': id
		}
	};
	return NEO4J.findPromise(query);
};

exports.findXebianByEmail = function(email) {
	var query = {
		'query' : 'MATCH (n: '+XEBIAN_TYPE+') WHERE n.email = {email} RETURN n',
		'params' : {
			'email': email
		}
	};
	return NEO4J.findPromise(query);
};

exports.findXebianSkillz = function(email){
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+')-[r:`'+SKILLZ_RELATION+'`]->s WHERE n.email = {email} RETURN s,r  order by r.like DESC, r.level DESC, s.name',
    'params' : {
      'email': email
    }
  };
  return NEO4J.findPromise(query);
};

exports.findXebiansByName = function(q){
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+') WHERE n.displayName =~ {q} RETURN n',
    'params': {
      'q': '(?i).*' + q + '.*'
    }
  };
  return NEO4J.findPromise(query);
};

exports.findXebiansBySkillz = function (skillName){
  var query = {
    'query' : 'MATCH (x: '+XEBIAN_TYPE+')-[r:`'+SKILLZ_RELATION+'`]->s WHERE s.name=~ {q} RETURN x.displayName, x.email, x.picture, r.level, r.like, s.name',
    'params': {
      'q': '(?i).*' + skillName + '.*'
    }
  };
  return NEO4J.findPromise(query,function(row){
    return {'xebianName': row[0], 'email': row[1], 'picture': row[2], 'level': row[3], 'like': row[4], 'skillName': row[5]};
  });
};

exports.findAvailableSkillzForXebian = function(email, skillQuery) {
  var query = {
    'query': 'MATCH (xebian: '+XEBIAN_TYPE+'), (skill: '+SKILL_TYPE+' ) WHERE skill.name =~ {skillQuery} and xebian.email = {email} and not (xebian) -[:HAS]-> (skill) RETURN skill.name order by upper(skill.name)',
    'params': {
      'email': email,
      'skillQuery': '(?i).*' + skillQuery + '.*'
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

exports.allSkillz = function() {
  var query = {
    'query': 'MATCH (s:' + SKILL_TYPE + ') OPTIONAL MATCH s<-[r:`HAS`]-() return s.name, count(r),id(s) order by upper(s.name)'
  };
  return NEO4J.findPromise(query, function(row){
      return {'name':row[0], 'count': row[1], 'nodeId': row[2]};
  });
};

exports.orphanSkillz = function(){
  var query = {
    'query': 'match (orphan:SKILL) where not ()-[:HAS]->(orphan) return orphan.name, id(orphan) order by upper(orphan.name)'
  };

  return NEO4J.findPromise(query,function(row){
    return {'nodeId': row[1], 'name': row[0]};
  });
};

var extractNodeIdPattern = /(\d*)$/;
var extractNodeId = function(nodeUrl) {
	return nodeUrl.match(extractNodeIdPattern)[1];
};

exports.userHasSkill = function(userNodeUrl, skillNodeUrl) {
	var userNodeId = extractNodeId(userNodeUrl);
	var skillNodeId = extractNodeId(skillNodeUrl);
	var query = {
		'query': 'start xebian=node( {userNodeId} ),skill=node( {skillNodeId} ) match (xebian)-[r:HAS]->(skill) return r',
		'params': {
			'userNodeId': Number(userNodeId),
			'skillNodeId': Number(skillNodeId)
		}
	};

	return NEO4J.findPromise(query);
};

exports.associateSkillToUser = function(userNodeUrl, skillNodeUrl, relation_properties) {
  var securedURL = NEO4J.makeURLSecured(userNodeUrl);

  var deferred = Q.defer();
  http
    .post(securedURL + '/relationships')
    .set('Accept', 'application/json; charset=UTF-8')
    .set('Content-Type', 'application/json')
    .send({
      'to' : skillNodeUrl,
      'type' : SKILLZ_RELATION,
      'data' : relation_properties
    })
    .end(function(err, res) {
      if (err) {
        deferred.reject(err);
      } else {
        console.log('associateSkillToUser', res.statusCode );
        deferred.resolve(res.body.self);
      }
    });
  return deferred.promise;
};

exports.deleteSkill = function(oldSkillId){
  var removeOldSkillQuery = {
      'query' : 'start oldSkill=node( {oldSkillId} )  OPTIONAL MATCH (oldSkill)-[r]-() DELETE oldSkill,r',
      'params': {
        'oldSkillId' : oldSkillId
      }
    };

    return NEO4J.execute(removeOldSkillQuery);
};

exports.mergeSkill = function(oldSkillId, newSkillId){
  var addNewRelationsQuery = {
    'query' : 'START oldSkill=node( {oldSkillId} ), newSkill=node( {newSkillId} ) match  (x: `'+XEBIAN_TYPE+'`)-[oldRelation:`'+SKILLZ_RELATION+'`]->oldSkill WHERE NOT (x)-[:`'+SKILLZ_RELATION+'`]->newSkill  create (x)-[r:`'+SKILLZ_RELATION+'` {level: oldRelation.level, like: oldRelation.like }]->(newSkill)',
    'params' : {
      'oldSkillId': oldSkillId,
      'newSkillId': newSkillId
    }
  };

  var addNewRelations = NEO4J.execute(addNewRelationsQuery);

  var self = this;

  return addNewRelations.then(function(){
    return self.deleteSkill(oldSkillId);
  });
};
