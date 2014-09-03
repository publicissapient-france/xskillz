'use strict';

//Setting up route
angular.module('admin').config(['$stateProvider',
	function($stateProvider) {
		// Admins state routing
		$stateProvider.
		state('indexAdmin', {
			url: '/admin',
			templateUrl: 'modules/admins/views/admin.client.view.html'
		});
	}
]);