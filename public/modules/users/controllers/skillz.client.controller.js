'use strict';

angular.module('users').controller('SkillzController', ['_', '$scope', '$http', '$location', 'Users', 'Authentication',
	function(_, $scope, $http, $location, Users, Authentication) {


			$scope.getSkills = function() {
          		$http.get('/skills').then(function(response){
					$scope.skillz = response.data;
				});
			};
			
			$scope.getSkills();


			$scope.deduplicate = function(){
				$http.post('/skills/deduplicate',{'source': $scope.source, 'destination': $scope.destination});
			};
	}


]);
