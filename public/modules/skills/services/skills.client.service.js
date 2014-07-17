'use strict';

//Skills service used to communicate Skills REST endpoints
angular.module('skills').factory('Skills', ['$resource',
	function($resource) {
		return $resource('skills/:skillId', { skillId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);