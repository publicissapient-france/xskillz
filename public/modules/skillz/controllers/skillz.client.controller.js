'use strict';

angular.module('skillz').controller('SkillzController', ['_', '$scope', '$http', '$location',
	function(_, $scope, $http, $location) {

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

			$scope.changingSearchSkillz = function() {
				$scope.results = [];
				if ($scope.query.length > 2) {
					$scope.searchSkillz();
				}
			};
	}


]);
