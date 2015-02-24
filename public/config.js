'use strict';

// Init the application configuration module for AngularJS application
var ApplicationConfiguration = (function() {

	var lodash = angular.module('lodash', []);
	lodash.factory('_', function() {
	  return window._; // assumes underscore has already been loaded on the page
	});

	var d3 = angular.module('d3', []);
	d3.factory('d3', function() {
		return window.d3; // assumes d3 has already been loaded on the page
	});

	// Init module configuration options
	var applicationModuleName = 'xskillz';
	var applicationModuleVendorDependencies = ['ngResource', 'ngCookies',  'ngAnimate',  'ngTouch',  'ngSanitize',  'ui.router', 'ui.bootstrap', 'ui.utils', 'lodash', 'd3', 'angulartics', 'angulartics.google.analytics', 'ui.gravatar'];

	// Add a new vertical module
	var registerModule = function(moduleName) {
		// Create angular module
		angular.module(moduleName, []);

		// Add the module to the AngularJS configuration file
		angular.module(applicationModuleName).requires.push(moduleName);
	};

	return {
		applicationModuleName: applicationModuleName,
		applicationModuleVendorDependencies: applicationModuleVendorDependencies,
		registerModule: registerModule
	};
})();
