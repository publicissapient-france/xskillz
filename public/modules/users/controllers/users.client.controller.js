'use strict';


console.log('loading users');

angular.module('users').controller('UsersController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
	function(_, $scope, $http, $location, Users, Authentication) {

		$scope.user = Authentication.user;

		$scope.skillz = [];
		$scope.results = [];

		var reset = function() {
			$scope.newSkill = '';
			$scope.oldLevel = $scope.level = 0;
			$scope.like = false;
		};
		reset();

		$scope.hoveringOver = function(value) {
			$scope.tempLevel = value;
	  };
		$scope.setLevel = function() {
			if ($scope.oldLevel === 1) {
				$scope.level = 0;
			} else {
				$scope.level = $scope.tempLevel;
			}
			$scope.oldLevel = $scope.tempLevel;
		};
		$scope.isLiked = function(like) {
			if (like) {
				return 'glyphicon-heart';
			} else {
				return 'glyphicon-heart-empty';
			}
		};
		$scope.toggleLike = function() {
			$scope.like = !$scope.like;
		};
		var transformResultToSkillz = function(response) {
			return _.map(response.data, function(node){
				return {'name' : node[0].data.name, 'level' : node[1].data.level , 'like' : node[1].data.like, relationId : node[1].self };
			});
		};
		var transformResultToXebians = function(response) {
			return _.map(response.data, function(node){
				return {
					'skillName': node[2].data.name,
					'email': node[0].data.email,
					'picture': node[0].data.picture,
					'displayName' : node[0].data.displayName,
					'firstName' : node[0].data.firstName,
					'lastName' : node[0].data.lastName,
					'level' : node[1].data.level ,
					'like' : node[1].data.like,
					relationId : node[1].self };
			});
		};

		$http.get('/users/me/skillz').then(function(response){
			$scope.skillz = _.map(response.data, function(node){
				return {'name' : node[0].data.name, 'level' : node[1].data.level , 'like' : node[1].data.like, relationId : node[1].self };
			});
		});

		// If user is not signed in then redirect back home
		if (!$scope.user) $location.path('/');

		$scope.removeRelation = function(relationId){
			$http.post('users/me/skillz/disassociate', {'relationship': relationId} ).then(function(response){
				$scope.skillz = transformResultToSkillz(response);
			});
		};

		// List all xebians corresponding to some skillz

		$scope.changingSearchSkillz = function() {
				if ($scope.query.length > 2) {
					$scope.searchSkillz();
				}
		};
		$scope.searchSkillz = function(){
			$scope.results = [];
			$http.get('/skillz', {'params': {'q':$scope.query}})
				.then(function(response){
					$scope.results = transformResultToXebians(response);
			});
		};

		// Affect a skill to current user
		$scope.associateSkill = function() {
			if ( ! (_.find($scope.skillz, function(skill){return skill.name === $scope.newSkill;} ))) {
					$http.put('users/me/skillz', { 'skill': {'name': $scope.newSkill}, 'relation_properties': {'level' : $scope.level , 'like' : $scope.like }})
						.then(function(response) {
								reset();
								$scope.skillz = transformResultToSkillz(response);
					});
			}
		};

		$scope.changingSearchXebians = function() {
				$scope.results = [];
				if ($scope.query.length > 2) {
					$scope.searchXebians();
				}
		};
		$scope.searchXebians = function(){
			$http.get('/users', {'params': {'q':$scope.query}})
				.then(function(response){
					$scope.results = response.data;
			});
		};

		// Get user profile
		$scope.getProfile = function() {
			console.log('get profile');
		};

		$scope.getSkills = function() {
          $http.get('/skills').then(function(response){
				$scope.skills = response.data;
			});
		};
		$scope.getSkills();

	}
]);
