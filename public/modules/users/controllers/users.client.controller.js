'use strict';

angular.module('users').controller('UsersController', ['$scope', '$http', '$location', 'Users', 'Authentication',
	function($scope, $http, $location, Users, Authentication) {

		$scope.user = Authentication.user;
		
		$scope.newSkill = '';

		$scope.skillz = [];

		$scope.results = [];

		$http.get('/users/me/skillz').then(function(response){
			$scope.skillz = _.map(response.data, function(node){
				return node;	
			});
		});

		// If user is not signed in then redirect back home
		if (!$scope.user) $location.path('/');

		$scope.removeRelation = function(relationId){
			console.log('remove relation ', relationId);

			$http.post('users/me/skillz/disassociate', {'relationship': relationId} ).then(function(response){
				$scope.skillz = _.map(response.data, function(node){
					return node;	
				});
			});
		};

		// List all xebians corresponding to some skillz
		$scope.search = function(){
			$http.get('/skillz', {'params': {'q':$scope.query}})
				.then(function(response){
					$scope.results = response.data;
			});
		};

		// Affect a skill to current user
		$scope.associateSkill = function() {
			if (_.indexOf($scope.skillz, $scope.newSkill) === -1 ) {
					$http.put('users/me/skillz', { 'skill': $scope.newSkill }).then(function(response) {
						$scope.skillz = _.map(response.data, function(node){
							return node;	
						});
				});
			}
		};

	}
]);
