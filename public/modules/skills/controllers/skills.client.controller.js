'use strict';

// Skills controller
angular.module('skills').controller('SkillsController', ['$scope', '$stateParams', '$location', 'Authentication', 'Skills', 
	function($scope, $stateParams, $location, Authentication, Skills) {
		$scope.authentication = Authentication;

		// Create new Skill
		$scope.create = function() {
			// Create new Skill object
			var skill = new Skills ({
				name: this.name
			});

			// Redirect after save
			skill.$save(function(response) {
				$location.path('skills/' + response._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});

			// Clear form fields
			this.name = '';
		};

		// Remove existing Skill
		$scope.remove = function( skill ) {
			if ( skill ) { skill.$remove();

				for (var i in $scope.skills ) {
					if ($scope.skills [i] === skill ) {
						$scope.skills.splice(i, 1);
					}
				}
			} else {
				$scope.skill.$remove(function() {
					$location.path('skills');
				});
			}
		};

		// Update existing Skill
		$scope.update = function() {
			var skill = $scope.skill ;

			skill.$update(function() {
				$location.path('skills/' + skill._id);
			}, function(errorResponse) {
				$scope.error = errorResponse.data.message;
			});
		};

		// Find a list of Skills
		$scope.find = function() {
			$scope.skills = Skills.query();
		};

		// Find existing Skill
		$scope.findOne = function() {
			$scope.skill = Skills.get({ 
				skillId: $stateParams.skillId
			});
		};

		$scope.skills = [];
        $scope.newSkill = 'test';

		// Affect a skill to current user
    	$scope.affectSkill = function() {

    		console.log('should add ' + $scope.newSkill + ' to ' + Authentication.user._id);

	        /*if (_.indexOf($scope.skills, $scope.newSkill) === -1) {


	            $http.put('skill/affect', $scope.newSkill).then(function(response) {
	                $scope.skills = response.data.skills;
	                $scope.newSkill = '';
	            });
	        }*/
		};
	}
]);