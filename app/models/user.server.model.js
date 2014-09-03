'use strict';

/**
 * Module dependencies.
 */
var xskillzNeo4J = require('../models/xskillz.neo4j'),
  _ = require('lodash');


exports.findOne = function(id){
  return xskillzNeo4J.findXebianById(id).then(
    function(user){
      try{
        var userData =  user[0][0].data;
        userData.roles = ['user'];
        return userData ;
      } catch(err){
        return null;
      }
    });
};

var makeFlatUser = function(user){
  var flatUser = _.extend(user,user.providerData);

  flatUser._id = flatUser.id;
  delete flatUser.id;
  delete flatUser.providerData;

  flatUser.username = flatUser.email;

  return flatUser;
};

exports.save = function(user, next) {

  var flatUser = makeFlatUser(user);

  xskillzNeo4J.findXebianById(flatUser._id)
    .then(function(xebian) {
      if (!xebian) {
        xskillzNeo4J.createXebian(flatUser)
          .then(function(node) {
            next();
          })
          .fail(function(error) {
            next(error);
          });
      } else {
				next();
			}
    })
    .fail(function(error) {
      next(error);
    });
};

exports.remove = function(next, done) {
 var self = this;

 xskillzNeo4J.deleteNode(self.nodeUrl)
   .then(function(status) {
     next();
   })
   .fail(function(error) {
     next(error);
   });
};