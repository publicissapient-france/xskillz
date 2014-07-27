'use strict';

// Setting up route
angular.module('users').config(['$stateProvider',
	function($stateProvider) {
		// Users state routing
		$stateProvider.
		state('associateSkill', {
			url: '/users/associate',
			templateUrl: 'modules/users/views/associate-skill.client.view.html'
		}).
		state('signin', {
			url: '/signin',
			templateUrl: 'modules/users/views/signin.client.view.html'
		});
	}
]);
