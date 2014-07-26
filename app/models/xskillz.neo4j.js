'use strict';

var http = require('superagent'),
  _ = require('lodash'),
  Q = require('q');

var neo4j_server_url = process.env.NEO4J_URL || 'http://localhost:7474';
var url = neo4j_server_url + '/db/data';

var XEBIAN_TYPE = 'XEBIAN';
var SKILL_TYPE = 'SKILL';

var getCypherQuery = function() {
  return http
    .post(url + '/cypher')
    .set('Accept', 'application/json; charset=UTF-8')
    .set('Content-Type', 'application/json');
};

var createNodePromise = function(nodeType, nodeData) {
  console.log(nodeType + 'node to be created: ' + nodeData);

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

exports.findXebian = function(email) {
  var query = {
    'query': 'MATCH (n: ' + XEBIAN_TYPE + ' ) WHERE n.email= { email } RETURN n',
    'params': {
      'email': email
    }
  };
  console.log('cypher query: ' + query);

  var deferred = Q.defer();
  getCypherQuery()
    .send(query)
    .end(function(err, res) {
      if (err) {
        deferred.reject(err);
      } else {
        console.log('cypher query result: ' + res.data);
        if (_.isEmpty(res.data)) {
          deferred.resolve(null);
        } else {
          deferred.resolve(_.first(res.data).data);
        }
      }
    });
  return deferred.promise;
};
