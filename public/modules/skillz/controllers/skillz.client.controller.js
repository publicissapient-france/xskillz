'use strict';

angular.module('skillz').directive('xebianSkillCard', function () {
    return {
        restrict: 'E',
        scope: {
            xebian: '=xebian',
            showRating: '=showRating',
            onClick: '&onClick'
        },
        templateUrl: 'modules/skillz/views/xebian-skill-card.template.html'
    };
});

angular.module('skillz').directive('help', ['$http', function ($http) {

    return {
        restrict: 'E',
        templateUrl: 'modules/skillz/views/help.template.html'
    };
}]);

angular.module('skillz').controller('SkillzController', ['$rootScope', '$scope', '$http', '$location', '_', 'd3',
    function ($rootScope, $scope, $http, $location, _, d3) {

        $scope.expertLevel = 3;
        $scope.confirmedLevel = 2;
        $scope.rookieLevel = 1;
        $scope.enthusiastLevel = 0;

        $scope.domains = ['Agile', 'Back', 'Cloud', 'Craft', 'Data', 'Devops', 'Front', 'Mobile'];

        $scope.years = _.range(new Date().getFullYear(), 1990, -1);

        $scope.help = function () {
            $scope.displayHelp = !$scope.displayHelp;
        };

        $scope.cloud = function () {
            var diameter = 960, format = d3.format(',d'), color = d3.scale.category20c();
            var bubble = d3.layout.pack()
                .sort(null)
                .size([diameter, diameter])
                .padding(15);
            var svg = d3.select('#cloud').append('svg')
                .attr('width', diameter)
                .attr('height', diameter)
                .attr('class', 'bubble');
            d3.json('/skills', function (error, root) {
                var node = svg.selectAll('.node')
                    .data(bubble.nodes(setClasses(root))
                        .filter(function (d) {
                            return !d.children;
                        }))
                    .enter().append('g')
                    .attr('class', 'node')
                    .attr('transform', function (d) {
                        return 'translate(' + d.x + ',' + d.y + ')';
                    });
                node.append('title')
                    .text(function (d) {
                        return d.name + ': ' + format(d.value);
                    });
                node.append('circle')
                    .attr('r', function (d) {
                        return d.r;
                    })
                    .style('fill', function (d) {
                        return color(d.value);
                    });
                node.append('a')
                    .attr({"xlink:href": "#"})
                    .on("mouseover", function(d, i){
                        d3.select(this)
                            .attr({"xlink:href": "#!/skillz/search?query=" + d.name});
                    })
                    .append('text')
                    .attr('dy', '.3em')
                    .style('text-anchor', 'middle')
                    .text(function (d) {
                        return d.name.substring(0, d.r / 4);
                    });
            });

            function setClasses(root) {
                var classes = [];
                root.forEach(function (node) {
                    classes.push({name: node.name, value: (node.count + 1)});
                });
                return {children: classes};
            }

            d3.select('#cloud').style('height', diameter + 'px');
        };
        $scope.cloud();

        $scope.getSkills = function () {
            $http.get('/skills').then(function (response) {
                $scope.skillz = response.data;
            });
        };

        $scope.getXebians = function () {
            $http.get('/users?q=.').then(function (response) {
                $scope.xebians = response.data;
            });
        };

        $scope.getSkills();
        $scope.getXebians();

        $scope.getOrphanSkillz = function () {
            $http.get('/skills/orphans').then(function (response) {
                $scope.orphanSkillz = response.data;
            });
        };

        $scope.getOrphanSkillz();


        $scope.merge = function () {
            $http.post('/skills/merge', {'source': $scope.source, 'destination': $scope.destination}).then(function (response) {
                $scope.skillz = response.data;
                $scope.getOrphanSkillz();
                $scope.source = {};
                $scope.destination = {};
            });
        };

        $scope.domainize = function () {
            $http.post('/skills/domains', {'skill': $scope.skill, 'domain': $scope.domain}).then(function (response) {
                $scope.skillz = response.data;
                $scope.skill = {};
                $scope.domain = {};
            });
        };

        $scope.diplomize = function () {
            $http.post('/user/diploma', {'email': $scope.xebian, 'diploma': $scope.year}).then(function (response) {
                $scope.getXebians();
                $scope.year = {};
                $scope.xebian = {};
            });
        };

        $scope.deleteSkill = function (nodeToDelete) {
            $http.post('/skills/delete', {'source': nodeToDelete}).then(function (response) {
                $scope.orphanSkillz = response.data;
                $scope.getSkills();
            });
        };

        var transformResultToXebians = function (response) {
            var values = _.map(response.data, function (node) {
                return {
                    'skillName': node.skillName,
                    'nameForSort': node.skillName.toLowerCase(),
                    'email': node.email,
                    'picture': node.picture,
                    'displayName': node.xebianName,
                    'level': node.level,
                    'like': node.like,
                    'experience': node.experience
                };
            });
            return _.sortBy(values, 'level').reverse();
        };

        $scope.searchSkillz = function () {
            $http.get('/skillz', {'params': {'q': $scope.query}})
                .then(function (response) {
                    $scope.results = transformResultToXebians(response);
                });
        };

        $scope.findSkillByName = function (skill) {
            $scope.query = skill;
            if (skill.length > 2) {
                $scope.searchSkillz();
            }
        };

        $scope.changingSearchSkillz = function () {
            $scope.results = [];
            if ($scope.query.length > 2) {
                $scope.searchSkillz();
            }
        };

        $scope.isLiked = function (like) {
            if (like) {
                return 'glyphicon-heart';
            } else {
                return 'glyphicon-heart-empty';
            }
        };

        // initialize
        if ($location.search().query) {
            $scope.query = $location.search().query;
            $scope.searchSkillz();
        }

    }

]);