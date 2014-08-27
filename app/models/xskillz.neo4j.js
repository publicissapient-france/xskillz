'use strict';

var http = require('superagent'),
  _ = require('lodash'),
  Q = require('q');

var neo4j_server_url = process.env.GRAPHENEDB_URL || 'http://localhost:7474';
var url = neo4j_server_url + '/db/data';

var XEBIAN_TYPE = 'XEBIAN';
var SKILL_TYPE = 'SKILL';

var KNOWS = 'KNOWS';

var credentialsNEO4J = url.match(/^https?:\/\/(.*)@/)[1] || null;

var getCypherQuery = function() {
  return http
    .post(url + '/cypher')
    .set('Accept', 'application/json; charset=UTF-8')
    .set('Content-Type', 'application/json');
};

var createNodePromise = function(nodeType, nodeData) {
  var deferred = Q.defer();
  getCypherQuery()
    .send({
      'query': 'CREATE (n:' + nodeType + ' { props } ) RETURN n',
      'params': {
        'props': nodeData
      }
    })
    .end(function(err, res) {
      if (err) {
        deferred.reject(err);
      } else {
        console.log('created node: ' + res.body.data[0][0].self);
        deferred.resolve(res.body.data[0][0].self);
      }
    });
  return deferred.promise;
};

exports.createXebian = function(user) {
  var xebian = {
    'email': user.email,
    'firstName': user.firstName,
    'lastName': user.lastName,
    'displayName': user.displayName
  };
  return createNodePromise(XEBIAN_TYPE, xebian);
};

exports.createSkill = function(skillName) {
  var skill = {
    'name': skillName
  };
  return createNodePromise(SKILL_TYPE, skill);
};

exports.deleteNode = function(nodeUrl) {
  var deferred = Q.defer();
  http
    .del(nodeUrl)
    .end(function(res){
      console.log('deleted node: ' + nodeUrl + ' with status ' + res.statusCode);
      deferred.resolve(res);
  });
  return deferred.promise;
};

var findPromise = function(query) {
  console.log('Cypher find query: ' + JSON.stringify(query));
  var deferred = Q.defer();
  getCypherQuery()
    .send(query)
    .end(function(err, res) {
      if (err) {
        deferred.reject(err);
      } else {
        console.log('query result: ' + JSON.stringify(res.body.data));
        if (_.isEmpty(res.body.data)) {
          deferred.resolve(null);
        } else {
          deferred.resolve(res.body.data);
        }
      }
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
  return findPromise(query);
};

exports.findXebianSkillz = function(email){
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+')-[:`'+KNOWS+'`]->s WHERE n.email = {email} RETURN s',
    'params' : {
      'email': email
    }
  };
  return findPromise(query);

};

exports.findXebiansBySkillz = function (skillName){
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+')-[r:`'+KNOWS+'`]->s WHERE s.name=~ \'(?i).*'+skillName+'.*\' RETURN n,r, s'
  };
  return findPromise(query);
};

exports.findSkill = function(name) {
  var query = {
    'query': 'MATCH (n: '+SKILL_TYPE+' ) WHERE n.name= {name} RETURN n',
    'params': {
      'name': name
    }
  };
  return findPromise(query);
};

exports.associateSkillToUser = function(userNodeUrl, skillNodeUrl) {
  console.log('userNodeUrl: ' + userNodeUrl);
  console.log('skillNodeUrl: ' + skillNodeUrl);

  var securedURL = userNodeUrl.replace(/:\/\//g,'://' + credentialsNEO4J + '@');

  console.log(securedURL);

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
        console.log('associateSkillToUser', res.statusCode, JSON.stringify(res.body) );
        deferred.resolve(res.body.self);
      }
    });
  return deferred.promise;
};
