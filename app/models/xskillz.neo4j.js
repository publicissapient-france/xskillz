'use strict';

var http = require('superagent'),
  _ = require('lodash'),
  Q = require('q'),
  NEO4J = require('./neo4j');

var XEBIAN_TYPE = 'XEBIAN';
var SKILL_TYPE = 'SKILL';

var KNOWS = 'KNOWS';


exports.createXebian = function(user) {
  return NEO4J.createNodePromise(XEBIAN_TYPE, user);
};

exports.createSkill = function(skillName) {
  var skill = {
    'name': skillName
  };
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
    'query' : 'MATCH (n: '+XEBIAN_TYPE+')-[r:`'+KNOWS+'`]->s WHERE n.email = {email} RETURN s,r',
    'params' : {
      'email': email
    }
  };
  return NEO4J.findPromise(query);

};

exports.findXebiansBySkillz = function (skillName){
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+')-[r:`'+KNOWS+'`]->s WHERE s.name=~ {q} RETURN n,r, s',
    'params': {
      'q': '(?i).*' + skillName + '.*'
    }
  };
  return NEO4J.findPromise(query);
};

exports.findSkill = function(name) {
  var query = {
    'query': 'MATCH (n: '+SKILL_TYPE+' ) WHERE n.name= {name} RETURN n',
    'params': {
      'name': name
    }
  };
  return NEO4J.findPromise(query);
};

exports.associateSkillToUser = function(userNodeUrl, skillNodeUrl) {
  var securedURL = NEO4J.makeURLSecured(userNodeUrl);

  var deferred = Q.defer();
  http
    .post(securedURL + '/relationships')
    .set('Accept', 'application/json; charset=UTF-8')
    .set('Content-Type', 'application/json')
    .send({
      'to' : skillNodeUrl,
      'type' : 'KNOWS'
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
