'use strict';

console.log('loading users');

angular.module('users').filter('noDomain', function () {
    return function (skills) {
        return _.filter(skills, function (skill) {
            return !skill.domains || skill.domains.length === 0;
        });
    };
});

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

angular.module('users').directive('skillCard', ['$http', '$location', function ($http) {

    function link(scope, element) {
        scope.updateLike = function (skill) {
            if (scope.readonly) {
                return;
            }
            skill.like = !skill.like;
            $http.put('/users/me/skillz/' + skill.relationId + '/like', {'like': skill.like}).then(function (response) {
            });
        };

        scope.hoveringOver = function (value) {
            if (scope.readonly) {
                return;
            }
            scope.tempLevel = value;
        };

        scope.setLevel = function () {
            if (scope.readonly) {
                return;
            }
            if (scope.oldLevel === 1) {
                scope.level = 0;
            } else {
                scope.level = scope.tempLevel;
            }
            scope.oldLevel = scope.tempLevel;
        };

        scope.updateLevel = function (skill) {
            if (scope.readonly) {
                return;
            }
            $http.put('/users/me/skillz/' + skill.relationId + '/level', {'level': skill.level});
        };

        scope.removeRelation = function (relationId) {
            if (scope.readonly) {
                return;
            }
            $http.post('users/me/skillz/disassociate', {'relationId': relationId}).then(function () {
                element.remove();
            });
        };
    }

    return {
        restrict: 'E',
        scope: {
            skill: '=skill',
            readonly: '=readonly'
        },
        link: link,
        templateUrl: 'modules/users/views/skill-card.template.html'
    };
}]);

function toBrand(email) {
    return email.match(/([\w-]+)@([\w-]+)/)[2];
}

angular.module('users').directive('domain', ['$http', function () {
    return {
        restrict: 'E',
        scope: {
            label: '=label',
            skills: '=skills',
            readonly: '=readonly'
        },
        templateUrl: 'modules/users/views/domain.template.html'
    };
}]);

angular.module('users').directive('experienceBadge', ['$http', function () {
    return {
        restrict: 'E',
        scope: {
            ally: '=ally'
        },
        templateUrl: 'modules/users/views/experience-badge.template.html',
        link: function (scope) {
            if(scope.ally) {
                scope.experience = scope.ally.experience;
                var alpha = 0.2 + scope.experience / 10;
                scope.email = scope.ally.email;
                var brand = toBrand(scope.email);
                if ('xebia' == brand) {
                    scope.backgroundColor = 'rgba(85, 26, 139,' + alpha + ')';
                }
                if ('wescale' == brand) {
                    scope.backgroundColor = 'rgba(9, 170, 157,' + alpha + ')';
                }
            }
        }
    };
}]);

angular.module('users').directive('brandBadge', ['$http', function () {
    return {
        restrict: 'E',
        scope: {
            ally: '=ally'
        },
        templateUrl: 'modules/users/views/brand-badge.template.html',
        link: function (scope) {
            var email = scope.ally.email;
            var brand = toBrand(email);
            if ('xebia' == brand) {
                scope.background = 'rgb(85, 26, 139)';
            }
            if ('wescale' == brand) {
                scope.background = '#09aa9d';
            }
            scope.brand = brand;
        }
    };
}]);

angular.module('users').directive('salesCard', function () {
    return {
        restrict: 'E',
        scope: {
            xebian: '=xebian',
            skills: '=skills'
        },
        templateUrl: 'modules/users/views/sales-card.template.html'
    };
});


angular.module('users').controller('UsersController', ['$scope', '$http', '$location', 'Users', 'Authentication', '_',
    function ($scope, $http, $location, Users, Authentication, _) {

        $scope.user = Authentication.user;
        $scope.user.isManager = _.contains(user.roles, 'MANAGER');
        $scope.user.experience = $scope.user.diploma ? new Date().getFullYear() - $scope.user.diploma : '-';

        $scope.back = 'Back';
        $scope.cloud = 'Cloud';
        $scope.front = 'Front';
        $scope.devops = 'Devops';
        $scope.agile = 'Agile';
        $scope.mobile = 'Mobile';
        $scope.data = 'Data';
        $scope.craft = 'Craft';
        $scope.loisirs = 'Loisirs';

        $scope.expertLevel = 3;
        $scope.confirmedLevel = 2;
        $scope.rookieLevel = 1;
        $scope.enthusiastLevel = 0;

        $scope.skillz = [];
        $scope.results = [];

        $scope.help = function () {
            $scope.displayHelp = !$scope.displayHelp;
        };

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
                $http.put('users/me/skillz', {
                    'skill': {'name': $scope.newSkill},
                    'relation_properties': {'level': $scope.level, 'like': $scope.like}
                })
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

        $http.get('/users', {'params': {'q': '.'}})
            .then(function (response) {
                $scope.xebians = response.data;
            });


// Get user profile
        $scope.getProfile = function () {
            console.log('get profile');
        };

        $scope.searchSkill = function (value) {
            return $http.get('/users/me/availableSkillz', {'params': {'q': value}})
                .then(function (response) {
                    return _.map(response.data, function (row) {
                        return row.name;
                    });
                });
        };

        $scope.updateLevel = function (skill) {
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

        $scope.isManager = function (user) {
            return _.contains(user.roles, 'MANAGER') || _.contains(user.roles, 'COMMERCE');
        };

        $scope.remove = function (email) {
            $http.delete('/user/' + email).then(function () {
                $scope.changingSearchXebians();
            });
        };
    }
]);

