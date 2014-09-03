'use strict';


console.log('loading profile');

angular.module('users').controller('ProfileController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
	function(_, $scope, $http, $location, Users, Authentication) {

		console.log('profile controller', $location.$$path.split('/').pop());
		var mail = $location.$$path.split('/').pop();

		$http.get('/user/'+mail).then(function(data) {
			$scope.user = data.data[0][0].data;
		});

		$http.get('/user/skillz/'+mail).then(function(data) {
			console.log(data);
		});





		// $scope.user = Authentication.user;

		// $scope.newSkill = '';

		// $scope.level = 0;

		// $scope.id = $routeParams.id;

	}
]);
