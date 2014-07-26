'use strict';


angular.module('core').controller('HomeController', ['$scope', '$http', '$location', 'Users', 'Authentication',
	function($scope, $http, $location, Users, Authentication) {

		$scope.deleteAccount = function() {
			var user = new Users(Authentication.user);

			user.$delete(function(response) {
				$location.path('/');
			}, function(response) {
				$scope.error = response.data.message;
			});
		};
	}
]);
