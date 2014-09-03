'use strict';

//Admins service used to communicate Admins REST endpoints
angular.module('admin').factory('Admin', ['$resource',
	function($resource) {
		return $resource('admin/:adminId', { adminId: '@_id'
		}, {
			update: {
				method: 'PUT'
			}
		});
	}
]);