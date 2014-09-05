'use strict';

// Configuring the Articles module
angular.module('core').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Mon profil', 'myskillz', 'item');
		Menus.addMenuItem('topbar', 'Chercher une compétence', 'skillz/search', 'item');
		Menus.addMenuItem('topbar', 'Chercher un Xebian', 'users/search', 'item');
		Menus.addMenuItem('topbar', 'Dataviz', 'skillz/cloudtag', 'item');
		Menus.addMenuItem('topbar', 'Administration', 'skillz/management', 'item');
	}
]);
