'use strict';

// Setting up route
angular
	.module('users').config(['$stateProvider',
	function($stateProvider) {
		// Users state routing
		$stateProvider.
		state('associateSkill', {
			url: '/users/associate',
			templateUrl: 'modules/users/views/associate-skill.client.view.html'
		}).
		state('signin',{
			url: '/signin',
			templateUrl: 'modules/users/views/signin.client.view.html'
		}).
		state('cloudtag',{
			url: '/cloudtag',
			templateUrl : 'modules/users/views/cloudtag.client.view.html',
		}).
		state('skillz',{
			url: '/skillz',
			templateUrl: 'modules/users/views/skillz.client.view.html'
		}).
		state('search',{
			url: '/users/search',			
			templateUrl: 'modules/users/views/users.client.view.html'
		}).
		state('profile',{
			url: '/user/:mail',
			// controller: function($scope){
			    
			//     $scope.title = 'My Contacts';
			//   },		
			//controller: 'ProfileController',
			templateUrl: 'modules/users/views/profile.client.view.html'
		});

	}]);
