'use strict';

var http = require('superagent'),
  _ = require('lodash'),
  Q = require('q');

var neo4j_server_url = process.env.GRAPHENEDB_URL || 'http://localhost:7474';
var url = neo4j_server_url + '/db/data';

console.log('NEO4J: ',neo4j_server_url);

var XEBIAN_TYPE = 'XEBIAN';
var SKILL_TYPE = 'SKILL';

var KNOWS = 'KNOWS';

var extractCredentials = /^https?:\/\/(.*)@/;

var isSecuredDatabase = function(){
  return extractCredentials.test(neo4j_server_url);
};

var makeURLSecured = function(unsecurred){
  if(isSecuredDatabase()){
    return unsecurred.replace(/:\/\//g,'://' + neo4j_server_url.match(extractCredentials)[1] + '@');
  }else{
    return unsecurred;
  }
};

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
        console.log('created node', res.statusCode,res.body.data[0][0].self || '');
        deferred.resolve(res.body.data[0][0].self);
      }
    });
  return deferred.promise;
};

exports.createXebian = function(user) {
  return createNodePromise(XEBIAN_TYPE, user);
};

exports.createSkill = function(skillName) {
  var skill = {
    'name': skillName
  };
  return createNodePromise(SKILL_TYPE, skill);
};

exports.deleteElement = function(elementURL) {
  var securedURL = makeURLSecured(elementURL);

  var deferred = Q.defer();
  http
    .del(securedURL)
    .end(function(res){
      console.log('deleted : ' + securedURL + ' with status ' + res.statusCode);
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
        console.log('query result count: ' + JSON.stringify(res.body.data.length));
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

exports.findXebianById = function(id) {
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+') WHERE n._id = {_id} RETURN n',
    'params' : {
      '_id': id
    }
  };
  return findPromise(query);
};

exports.findXebianSkillz = function(email){
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+')-[r:`'+KNOWS+'`]->s WHERE n.email = {email} RETURN s,r',
    'params' : {
      'email': email
    }
  };
  return findPromise(query);

};

exports.findXebiansBySkillz = function (skillName){
  var query = {
    'query' : 'MATCH (n: '+XEBIAN_TYPE+')-[r:`'+KNOWS+'`]->s WHERE s.name=~ {q} RETURN n,r, s',
    'params': {
      'q': '(?i).*' + skillName + '.*'
    }
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
  var securedURL = makeURLSecured(userNodeUrl);

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
