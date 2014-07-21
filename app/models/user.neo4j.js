'use strict';

var http = require('superagent'),
    _ = require('lodash');

var neo4j_server_url = process.env.NEO4J_URL || 'http://localhost:7474';
var url = neo4j_server_url + '/db/data';

var XEBIAN_TYPE = 'XEBIAN';

var executeCypherQuery = function(query) {
console.log('executeCypherQuery query: ' + xebians);
  http
    .post(url + '/cypher')
    .send(query)
    .set('Accept', 'application/json; charset=UTF-8')
    .set('Content-Type', 'application/json')
    .end(function(error, res) {
      console.log('executeCypherQuery query: ' + res.data);
    });
};

var createNode = function(nodeType, nodeData) {
  console.log('Xebian node to be created: ' + this);
  http
    .post(url + '/cypher')
    .send({
      'query': 'CREATE (n:' + nodeType + ' { props } ) RETURN n',
      'params': {
        'props': nodeData
      }
    })
    .set('Accept', 'application/json; charset=UTF-8')
    .set('Content-Type', 'application/json')
    .end(function(error, res) {
      console.log(res);
      return res.data;
    });
};

exports.findXebian = function(email) {
  var query = {
    'query': 'MATCH (n: '+XEBIAN_TYPE+' ) WHERE n.email= { email } RETURN n',
    'params': {
      'email': email
    }
  };
  var xebians = executeCypherQuery(query);
  if (_.isEmpty(xebians)) {
    return null;
  } else {
    return _.first(xebians).data;
  }
};

exports.createXebian = function(user) {
  var xebian = {
    'email': user.email,
    'firstName': user.lastName,
    'lastName': user.lastName,
    'displayName': user.displayName
  };
  return createNode(XEBIAN_TYPE, xebian);
};
