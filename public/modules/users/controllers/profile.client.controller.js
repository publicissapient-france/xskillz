'use strict';


console.log('loading profile');

angular.module('users').controller('ProfileController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
    function (_, $scope, $http, $location, Users, Authentication) {

        $scope.back = 'Back';
        $scope.cloud = 'Cloud';
        $scope.front = 'Front';
        $scope.devops = 'Devops';
        $scope.agile = 'Agile';
        $scope.mobile = 'Mobile';
        $scope.data = 'Data';
        $scope.craft = 'Craft';
        $scope.loisirs = 'Loisirs';

        console.log('profile controller', $location.$$path.split('/').pop());
        var mail = $location.$$path.split('/').pop();

        $http.get('/user/' + mail).then(function (response) {
            $scope.user = response.data;
            $scope.user.experience =  $scope.user.diploma ? new Date().getFullYear() - $scope.user.diploma : '-';
        });

        $http.get('/user/skillz/' + mail).then(function (response) {
            $scope.skillz = response.data;
        });

        $scope.me = Authentication.user;

    }
]);
