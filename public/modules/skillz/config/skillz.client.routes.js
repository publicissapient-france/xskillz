'use strict';

// Setting up route
angular
    .module('skillz').config(['$stateProvider',
        function ($stateProvider) {
            // Users state routing
            $stateProvider.
                state('skillz/search', {
                    url: '/skillz/search',
                    templateUrl: 'modules/skillz/views/search.client.view.html'
                }).
                state('skillz/cloudtag', {
                    url: '/skillz/cloudtag',
                    templateUrl: 'modules/skillz/views/cloudtag.client.view.html'
                }).
                state('skillz/ordering', {
                    url: '/skillz/ordering',
                    templateUrl: 'modules/skillz/views/ordering.client.view.html'
                }).
                state('skillz/management', {
                    url: '/skillz/management',
                    templateUrl: 'modules/skillz/views/management.client.view.html'
                });
        }]);
