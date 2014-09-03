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
        return userData;
      } catch(err){
        return null;
      }
    });
};

exports.importUserWithDomainDirectoryData = function (gData, next) {

	var user = {
		firstName: gData.firstName,
		lastName: gData.lastName,
		email: gData.email,
		picture: gData.picture
	};

	xskillzNeo4J.findXebianByEmail(user.email)
		.then(function (xebian) {
			if (!xebian) {
				xskillzNeo4J.createXebian(user)
					.then(function () {
						next();
					})
					.fail(function (error) {
						next(error);
					});
			} else {
				next();
			}
		})
		.fail(function (error) {
			next(error);
		});
};

exports.importUserWithGoogleAuthData = function (authData, next) {

	var userData = {
		_id: authData.providerData.id,
		displayName: authData.displayName,
		firstName: authData.firstName,
		lastName: authData.lastName,
		email: authData.email,
		accessToken: authData.providerData.accessToken,
		gender: authData.providerData.gender,
		link: authData.providerData.link,
		picture: authData.providerData.picture
	};

	xskillzNeo4J.findXebianByEmail(userData.email)
		.then(function (xebian) {
			if (!xebian) {
				xskillzNeo4J.createXebian(userData)
					.then(function () {
						next();
					})
					.fail(function (error) {
						next(error);
					});
			} else {
				var mergedUserData = _.extend(xebian[0][0].data, userData);
				xskillzNeo4J.updateXebian(mergedUserData)
					.then(function () {
						next();
					})
					.fail(function (error) {
						next(error);
					});
			}
		})
		.fail(function (error) {
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