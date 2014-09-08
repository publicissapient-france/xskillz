'use strict';

angular.module('skillz').controller('SkillzController', ['$scope', '$http', '$location', '_', 'd3',
	function($scope, $http, $location, _, d3) {

      $scope.cloud = function() {
          var diameter = 960, format = d3.format(',d'), color = d3.scale.category20c();
          var bubble = d3.layout.pack()
              .sort(null)
              .size([diameter, diameter])
              .padding(15);
          var svg = d3.select('#cloud').append('svg')
              .attr('width', diameter)
              .attr('height', diameter)
              .attr('class', 'bubble');
          d3.json('/skills', function(error, root) {
              var node = svg.selectAll('.node')
                  .data(bubble.nodes(setClasses(root))
                      .filter(function(d) { return !d.children; }))
                  .enter().append('g')
                  .attr('class', 'node')
                  .attr('transform', function(d) { return 'translate(' + d.x + ',' + d.y + ')'; });
              node.append('title')
                  .text(function(d) { return d.name + ': ' + format(d.value); });
              node.append('circle')
                  .attr('r', function(d) { return d.r; })
                  .style('fill', function(d) { return color(d.value); });
              node.append('text')
                  .attr('dy', '.3em')
                  .style('text-anchor', 'middle')
                  .text(function(d) { return d.name.substring(0, d.r/4); });
          });

          function setClasses(root) {
              var classes = [];
              root.forEach(function(node){
                  classes.push({name:node.name, value:(node.count+1)});
              });
              return {children: classes};
          }
          d3.select('#cloud').style('height', diameter + 'px');
      };
      $scope.cloud();

			$scope.getSkills = function() {
          		$http.get('/skills').then(function(response){
					$scope.skillz = response.data;
				});
			};
			
			$scope.getSkills();

			$scope.getOrphanSkillz = function(){
				$http.get('/skills/orphans').then(function(response){
					$scope.orphanSkillz = response.data;	
				});
			};

			$scope.getOrphanSkillz();


			$scope.merge = function(){
				$http.post('/skills/merge',{'source': $scope.source, 'destination': $scope.destination}).then(function(response){
					$scope.skillz = response.data;
					$scope.getOrphanSkillz();
					$scope.source = {};
					$scope.destination = {};
				});
			};

			$scope.deleteSkill = function(nodeToDelete){
				$http.post('/skills/delete',{'source': nodeToDelete}).then(function(response){
					$scope.orphanSkillz = response.data;
					$scope.getSkills();
				});
			};

			var transformResultToXebians = function(response) {
				var values = _.map(response.data, function(node){
					return {
						'skillName': node[2].data.name,
						'nameForSort': node[2].data.name.toLowerCase(),
						'email': node[0].data.email,
						'picture': node[0].data.picture,
						'displayName' : node[0].data.displayName,
						'firstName' : node[0].data.firstName,
						'lastName' : node[0].data.lastName,
						'level' : node[1].data.level ,
						'like' : node[1].data.like,
						relationId : node[1].self };
				});
				return _.sortBy(values, 'level').reverse();
			};
		
			$scope.searchSkillz = function(){
				$http.get('/skillz', {'params': {'q':$scope.query}})
					.then(function(response){
						$scope.results = transformResultToXebians(response);
				});
			};

      $scope.findSkillByName = function(skill) {
        $scope.query = skill;
        if (skill.length > 2) {
          $scope.searchSkillz();
        }
      };

			$scope.changingSearchSkillz = function() {
				$scope.results = [];
				if ($scope.query.length > 2) {
					$scope.searchSkillz();
				}
			};

			$scope.isLiked = function(like) {
			if (like) {
				return 'glyphicon-heart';
			} else {
				return 'glyphicon-heart-empty';
			}
		};
	}


]);
