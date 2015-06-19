'use strict';

// Configuring the Articles module
angular.module('core').run(['Menus',
	function(Menus) {
		// Set top bar menu items
		Menus.addMenuItem('topbar', 'Mon profil', 'myskillz', 'item', null, false, ['XEBIAN']);
		Menus.addMenuItem('topbar', 'Chercher une compétence', 'skillz/search', 'item', null, false, ['XEBIAN']);
		Menus.addMenuItem('topbar', 'Chercher un Allié', 'users/search', 'item', null, false, ['XEBIAN']);
		Menus.addMenuItem('topbar', 'Classer les compétences', 'skillz/ordering', 'item', null, false, ['XEBIAN']);
		Menus.addMenuItem('topbar', 'Dataviz', 'skillz/cloudtag', 'item', null, false, ['XEBIAN']);
		Menus.addMenuItem('topbar', 'Administration', 'skillz/management', 'item', null, false, ['MANAGER']);
	}
]);
