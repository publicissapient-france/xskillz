'use strict';

// Admins controller
angular.module('admin').controller('AdminController', ['$scope', '$stateParams', '$location', 'Authentication', 'Admin',
	function($scope, $stateParams, $location, Authentication, Admin ) {
		$scope.authentication = Authentication;
	}
]);