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

        var mail = $location.$$path.split('/').pop();

        $http.get('/user/' + mail).then(function (response) {
            $scope.user = response.data;
            $scope.user.experience = $scope.user.diploma ? new Date().getFullYear() - $scope.user.diploma : '-';
        });

        $http.get('/user/skillz/' + mail).then(function (response) {
            $scope.skillz = response.data;
        });

        $scope.me = Authentication.user;

        $scope.salesCard = function () {
            $scope.displaySalesCard = !$scope.displaySalesCard;
        };

        $scope.hasSkillzInDomain = function (domain) {
            return _.filter($scope.skillz, function (skill) {
                    if (skill.domains) {
                        var domainsInUpperCase = _.map(skill.domains, function (domain) {
                                return domain.toUpperCase();
                            }
                        );
                        return domainsInUpperCase.indexOf(domain.toUpperCase()) >= 0;
                    }
                    return false;
                }).length > 0;
        }

    }
]);
