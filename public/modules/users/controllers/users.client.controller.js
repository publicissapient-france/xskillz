'use strict';

angular.module('users').controller('UsersController', ['$scope', '$http', '$location', 'Users', 'Authentication',
	function($scope, $http, $location, Users, Authentication) {
		$scope.user = Authentication.user;
		$scope.newSkill = '';

		// If user is not signed in then redirect back home
		if (!$scope.user) $location.path('/');

		// Affect a skill to current user
		$scope.associateSkill = function() {
			if (window._.indexOf($scope.user.skills, $scope.newSkill) === -1) {
					$scope.user.skills.push();
					$http.put('users/associate', { 'skill': $scope.newSkill }).then(function(response) {
							$scope.user = response.data;
							$scope.newSkill = '';
					});
			}
		};

	}
]);
