'use strict';

angular.module('users').controller('SkillzController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
	function(_, $scope, $http, $location, Users, Authentication) {

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
	}


]);
