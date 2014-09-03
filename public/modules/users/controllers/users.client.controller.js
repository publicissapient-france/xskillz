'use strict';

angular.module('users').controller('UsersController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
	function(_, $scope, $http, $location, Users, Authentication) {

		$scope.user = Authentication.user;

		$scope.newSkill = '';

		$scope.level = 0;

		$scope.like = true;
		$scope.isLiked = function() {
			if ($scope.like) {
				return 'liked';
			} else {
				return '';
			}
		};
		$scope.toggleLike = function() {
			$scope.like = !$scope.like;
		};

		$scope.skillz = [];

		$scope.results = [];

		$http.get('/users/me/skillz').then(function(response){
			$scope.skillz = _.map(response.data, function(node){
				return {'name' : node[0].data.name, 'level' : node[1].data.level , 'like' : node[1].data.like };
			});
		});

		// If user is not signed in then redirect back home
		if (!$scope.user) $location.path('/');

		$scope.removeRelation = function(relationId){
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
			if ( ! (_.find($scope.skillz, function(skill){return skill.name === $scope.newSkill;} ))) {
					$http.put('users/me/skillz', { 'skill': {'name': $scope.newSkill}, 'relation_properties': {'level' : $scope.level , 'like' : $scope.like }}).then(function(response) {
						$scope.skillz = _.map(response.data, function(node){
							return {'name' : node[0].data.name, 'level' : node[1].data.level , 'like' : node[1].data.like };
						});
				});
			}
		};

		$scope.searchXebians = function(){
			$http.get('/users', {'params': {'q':$scope.query}})
				.then(function(response){
					$scope.results = response.data;
			});
		};

	}
]);
