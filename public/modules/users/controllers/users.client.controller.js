'use strict';

console.log('loading users');

angular.module('users').filter('partOfDomain', function () {
    return function (skills, domain) {
        return _.filter(skills, function (skill) {
            if (skill.domains) {
                var domainsInUpperCase = _.map(skill.domains, function (domain) {
                        return domain.toUpperCase();
                    }
                );
                return domainsInUpperCase.indexOf(domain.toUpperCase()) >= 0;
            }
            return false;
        });
    };
});

angular.module('users').directive('domain', function () {
    return {
        restrict: 'E',
        scope: {
            label: '=label',
            skills: '=skills'
        },
        templateUrl: 'modules/users/views/domain.template.html'
    };
});

angular.module('users').controller('UsersController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
    function (_, $scope, $http, $location, Users, Authentication) {

        $scope.user = Authentication.user;

        $scope.back = 'Back';
        $scope.cloud = 'Cloud';
        $scope.front = 'Front';
        $scope.devops = 'Devops';
        $scope.agile = 'Agile';
        $scope.mobile = 'Mobile';
        $scope.data = 'Data';
        $scope.craft = 'Craft';

        $scope.skillz = [];
        $scope.results = [];

        var reset = function () {
            $scope.newSkill = '';
            $scope.oldLevel = $scope.level = 0;
            $scope.like = false;
        };
        reset();

        $scope.hoveringOver = function (value) {
            $scope.tempLevel = value;
        };
        $scope.setLevel = function () {
            if ($scope.oldLevel === 1) {
                $scope.level = 0;
            } else {
                $scope.level = $scope.tempLevel;
            }
            $scope.oldLevel = $scope.tempLevel;
        };

        $scope.toggleLike = function () {
            $scope.like = !$scope.like;
        };

        $http.get('/users/me/skillz').then(function (response) {
            $scope.skillz = response.data;
        });

// If user is not signed in then redirect back home
        if (!$scope.user) $location.path('/');

        $scope.removeRelation = function (relationId) {
            $http.post('users/me/skillz/disassociate', {'relationId': relationId}).then(function (response) {
                $scope.skillz = response.data;
            });
        };

// Affect a skill to current user
        $scope.associateSkill = function () {
            if (!(_.find($scope.skillz, function (skill) {
                return skill.name === $scope.newSkill;
            }))) {
                $http.put('users/me/skillz', { 'skill': {'name': $scope.newSkill}, 'relation_properties': {'level': $scope.level, 'like': $scope.like }})
                    .then(function (response) {
                        reset();
                        $scope.skillz = response.data;
                    });
            }
        };

        $scope.changingSearchXebians = function () {
            $scope.results = [];
            if ($scope.query.length > 2) {
                $scope.searchXebians();
            }
        };
        $scope.searchXebians = function () {
            $http.get('/users', {'params': {'q': $scope.query}})
                .then(function (response) {
                    $scope.results = response.data;
                });
        };

// Get user profile
        $scope.getProfile = function () {
            console.log('get profile');
        };

        $scope.searchSkill = function (value) {
            return $http.get('/users/me/availableSkillz', {'params': {'q': value}})
                .then(function (response) {
                    return _.map(response.data, function (row) {
                        return row[0];
                    });
                });
        };

        $scope.updateLevel = function (skill) {
            console.log(skill);
            $http.put('/users/me/skillz/' + skill.relationId + '/level', {'level': skill.level}).then(function (response) {
                $scope.skillz = response.data;
            });
        };

        $scope.updateLike = function (skill) {
            skill.like = !skill.like;
            $http.put('/users/me/skillz/' + skill.relationId + '/like', {'like': skill.like}).then(function (response) {
                $scope.skillz = response.data;
            });
        };
    }
]);

