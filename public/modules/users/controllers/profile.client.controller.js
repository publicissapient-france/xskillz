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

        console.log('profile controller', $location.$$path.split('/').pop());
        var mail = $location.$$path.split('/').pop();

        $http.get('/user/' + mail).then(function (data) {
            $scope.user = data.data[0][0].data;
        });

		$http.get('/user/skillz/'+mail).then(function(response) {
			$scope.skillz = response.data;
		});

    }
]);
