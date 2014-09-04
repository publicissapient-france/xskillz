'use strict';

// Setting up route
angular
	.module('users').config(['$stateProvider',
	function($stateProvider) {
		// Users state routing
		$stateProvider.
		state('myskillz', {
			url: '/myskillz',
			templateUrl: 'modules/users/views/myskillz.client.view.html'
		}).
		state('signin',{
			url: '/signin',
			templateUrl: 'modules/users/views/signin.client.view.html'
		}).
		state('search',{
			url: '/users/search',			
			templateUrl: 'modules/users/views/search.client.view.html'
		}).
		state('profile',{
			url: '/user/:mail',
			templateUrl: 'modules/users/views/profile.client.view.html'
		});

	}]);
