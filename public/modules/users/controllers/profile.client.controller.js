'use strict';


console.log('loading profile');

angular.module('users').controller('ProfileController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
    function (_, $scope, $http, $location, Users, Authentication) {

        console.log('profile controller', $location.$$path.split('/').pop());
        var mail = $location.$$path.split('/').pop();

        $http.get('/user/' + mail).then(function (data) {
            $scope.user = data.data[0][0].data;
        });

        $http.get('/user/skillz/' + mail).then(function (data) {
            $scope.skillz = _.map(data.data, function (node) {
                return {
                    'name': node[0].data.name,
                    'level': node[1].data.level,
                    'like': node[1].data.like,
                    relationId: node[1].self
                };
            });
        });

        $scope.isLiked = function (like) {
            if (like) {
                return 'glyphicon-heart';
            } else {
                return 'glyphicon-heart-empty';
            }
        };

    }
]);
