'use strict';

angular.module('core').directive('notification', function () {
    return {
        restrict: 'E',
        scope: {
            notification: '=notification',
        },
        templateUrl: 'modules/core/views/notification.template.html'
    };
});

angular.module('core').filter('levelName', function() {
    return function(input) {
        if(input == 0) return 'intéressé(e)';
        if(input == 1) return 'débutant(e)';
        if(input == 2) return 'confirmé(e)';
        if(input == 3) return 'expert(e)';
    };
});

angular.module('core').controller('HomeController', ['$scope', '$http', '$location', 'Users', 'Authentication',
    function ($scope, $http, $location, Users, Authentication) {

        $http.get('/users/notifications')
            .then(function (response) {
                $scope.notifications = response.data;
            });

        $scope.deleteAccount = function () {
            var user = new Users(Authentication.user);

            user.$delete(function (response) {
                $location.path('/');
            }, function (response) {
                $scope.error = response.data.message;
            });
        };
    }
]);
