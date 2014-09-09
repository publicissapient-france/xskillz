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
				console.log('[SUCCESS]',res.statusCode,query);
				deferred.resolve();
			}
		});
	return deferred.promise;
};

exports.findPromise = function(query, mapper) {
  var deferred = Q.defer();
  getCypherQuery()
    .send(query)
    .end(function(err, res) {
      if (err || (res.statusCode !== 200)) {
  		console.log('[ERROR]',err || res.statusCode, JSON.stringify(query));

        deferred.reject(err||res.statusCode);
      } else {
      	  console.log('[SUCCESS]',res.body.data.length,'rows for', JSON.stringify(query));
	      if(mapper){
	      	deferred.resolve(_.map(res.body.data,mapper));
	      }else{
	      	deferred.resolve(res.body.data);
        }
      }
    });
  return deferred.promise;
};

exports.deleteElement = function(elementURL) {
    var securedURL = this.makeURLSecured(elementURL);

    var deferred = Q.defer();
    http
        .del(securedURL)
        .end(function(res){
            console.log('deleted : ' + securedURL + ' with status ' + res.statusCode);
            deferred.resolve(res);
        });
    return deferred.promise;
};

exports.XEBIAN_TYPE = 'XEBIAN';
exports.SKILL_TYPE = 'SKILL';

exports.SKILLZ_RELATION = 'HAS';