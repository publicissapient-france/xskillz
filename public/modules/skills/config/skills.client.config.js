'use strict';

// Configuring the Articles module
angular.module('skills').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'My skills', 'skills/affect', 'item');
		Menus.addMenuItem('topbar', 'Search for skills', 'skills', 'item');
	}
]);