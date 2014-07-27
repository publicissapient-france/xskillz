'use strict';

//Setting up route
angular.module('skills').config(['$stateProvider',
	function($stateProvider) {
		// Skills state routing
		$stateProvider.
		state('listSkills', {
			url: '/skills',
			templateUrl: 'modules/skills/views/list-skills.client.view.html'
		}).
		state('affectSkill', {
			url: '/skills/associate',
			templateUrl: 'modules/skills/views/associate-skill.client.view.html'
		}).
		state('createSkill', {
			url: '/skills/create',
			templateUrl: 'modules/skills/views/create-skill.client.view.html'
		}).
		state('viewSkill', {
			url: '/skills/:skillId',
			templateUrl: 'modules/skills/views/view-skill.client.view.html'
		}).
		state('editSkill', {
			url: '/skills/:skillId/edit',
			templateUrl: 'modules/skills/views/edit-skill.client.view.html'
		});
	}
]);
