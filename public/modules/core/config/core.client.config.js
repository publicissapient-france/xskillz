'use strict';

// Configuring the Articles module
angular.module('core').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'My skills', 'myskillz', 'item');
		Menus.addMenuItem('topbar', 'Search for skills', 'skillz/search', 'item');
		Menus.addMenuItem('topbar', 'Search for xebians', 'users/search', 'item');
		Menus.addMenuItem('topbar', 'VIZ', 'skillz/cloudtag', 'item');
		Menus.addMenuItem('topbar', 'Skillz management', 'skillz/management', 'item');
	}
]);
