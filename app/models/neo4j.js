'use strict';

var http = require('superagent'),
  _ = require('lodash'),
  Q = require('q');

var neo4j_server_url = process.env.GRAPHENEDB_URL || 'http://localhost:7474';
var url = neo4j_server_url + '/db/data';

console.log('NEO4J: ',neo4j_server_url);


var extractCredentials = /^https?:\/\/(.*)@/;

exports.isSecuredDatabase = function(){
  return extractCredentials.test(neo4j_server_url);
};

exports.makeURLSecured = function(unsecurred){
  if(this.isSecuredDatabase()){
    return unsecurred.replace(/:\/\//g,'://' + neo4j_server_url.match(extractCredentials)[1] + '@');
  }else{
    return unsecurred;
  }
};

var extractNodeIdPattern = /(\d*)$/;

exports.extractNodeId = function(nodeUrl){
	return Number(nodeUrl.match(extractNodeIdPattern)[1]);
};


var getCypherQuery = function() {
  return http
    .post(url + '/cypher')
    .set('Accept', 'application/json; charset=UTF-8')
    .set('Content-Type', 'application/json');
};

exports.createNodePromise = function(nodeType, nodeData) {
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
				console.log('created node', res.statusCode,res.body.data[0][0].self || '');
				deferred.resolve(res.body.data[0][0].self);
			}
		});
	return deferred.promise;
};

exports.updateNodePromise = function(nodeType, nodeKey, nodeValue, nodeData) {
	var deferred = Q.defer();

	getCypherQuery()
		.send({
			'query': 'MATCH (n:' + nodeType + ') where n.' + nodeKey + '= { nodeValue } SET n = { props }',
			'params': {
				'nodeValue': nodeValue,
				'props': nodeData
			}
		})
		.end(function(err, res) {
			if (err) {
				deferred.reject(err);
			} else {
				console.log('updated node', res.statusCode);
				deferred.resolve();
			}
		});
	return deferred.promise;
};

exports.execute = function(query){
	var deferred = Q.defer();

	getCypherQuery()
		.send(query)
		.end(function(err, res) {
			if (err) {
				deferred.reject(err);
			} else {
				console.log('updated node', res.statusCode);
				deferred.resolve();
			}
		});
	return deferred.promise;
};

exports.findPromise = function(query) {
  console.log('Cypher find query: ' + JSON.stringify(query));
  var deferred = Q.defer();
  getCypherQuery()
    .send(query)
    .end(function(err, res) {
	  console.log("Query: " + JSON.stringify(query), "res: " + JSON.stringify(res ? (res.body ? res.body.data : "") : ""));
      if (err) {
        deferred.reject(err);
      } else {
        if (_.isEmpty(res.body.data)) {
          deferred.resolve(null);
        } else {
          deferred.resolve(res.body.data);
        }
      }
    });
  return deferred.promise;
};