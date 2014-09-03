'use strict';

// Configuring the Articles module
angular.module('admin').run(['Menus',
	function(Menus) {
		Menus.addSubMenuItem('topbar', 'admin', 'Admin', 'admin');
	}
]);