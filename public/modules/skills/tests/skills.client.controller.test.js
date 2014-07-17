'use strict';

(function() {
	// Skills Controller Spec
	describe('Skills Controller Tests', function() {
		// Initialize global variables
		var SkillsController,
		scope,
		$httpBackend,
		$stateParams,
		$location;

		// The $resource service augments the response object with methods for updating and deleting the resource.
		// If we were to use the standard toEqual matcher, our tests would fail because the test values would not match
		// the responses exactly. To solve the problem, we define a new toEqualData Jasmine matcher.
		// When the toEqualData matcher compares two objects, it takes only object properties into
		// account and ignores methods.
		beforeEach(function() {
			jasmine.addMatchers({
				toEqualData: function(util, customEqualityTesters) {
					return {
						compare: function(actual, expected) {
							return {
								pass: angular.equals(actual, expected)
							};
						}
					};
				}
			});
		});

		// Then we can start by loading the main application module
		beforeEach(module(ApplicationConfiguration.applicationModuleName));

		// The injector ignores leading and trailing underscores here (i.e. _$httpBackend_).
		// This allows us to inject a service but then attach it to a variable
		// with the same name as the service.
		beforeEach(inject(function($controller, $rootScope, _$location_, _$stateParams_, _$httpBackend_) {
			// Set a new global scope
			scope = $rootScope.$new();

			// Point global variables to injected services
			$stateParams = _$stateParams_;
			$httpBackend = _$httpBackend_;
			$location = _$location_;

			// Initialize the Skills controller.
			SkillsController = $controller('SkillsController', {
				$scope: scope
			});
		}));

		it('$scope.find() should create an array with at least one Skill object fetched from XHR', inject(function(Skills) {
			// Create sample Skill using the Skills service
			var sampleSkill = new Skills({
				name: 'New Skill'
			});

			// Create a sample Skills array that includes the new Skill
			var sampleSkills = [sampleSkill];

			// Set GET response
			$httpBackend.expectGET('skills').respond(sampleSkills);

			// Run controller functionality
			scope.find();
			$httpBackend.flush();

			// Test scope value
			expect(scope.skills).toEqualData(sampleSkills);
		}));

		it('$scope.findOne() should create an array with one Skill object fetched from XHR using a skillId URL parameter', inject(function(Skills) {
			// Define a sample Skill object
			var sampleSkill = new Skills({
				name: 'New Skill'
			});

			// Set the URL parameter
			$stateParams.skillId = '525a8422f6d0f87f0e407a33';

			// Set GET response
			$httpBackend.expectGET(/skills\/([0-9a-fA-F]{24})$/).respond(sampleSkill);

			// Run controller functionality
			scope.findOne();
			$httpBackend.flush();

			// Test scope value
			expect(scope.skill).toEqualData(sampleSkill);
		}));

		it('$scope.create() with valid form data should send a POST request with the form input values and then locate to new object URL', inject(function(Skills) {
			// Create a sample Skill object
			var sampleSkillPostData = new Skills({
				name: 'New Skill'
			});

			// Create a sample Skill response
			var sampleSkillResponse = new Skills({
				_id: '525cf20451979dea2c000001',
				name: 'New Skill'
			});

			// Fixture mock form input values
			scope.name = 'New Skill';

			// Set POST response
			$httpBackend.expectPOST('skills', sampleSkillPostData).respond(sampleSkillResponse);

			// Run controller functionality
			scope.create();
			$httpBackend.flush();

			// Test form inputs are reset
			expect(scope.name).toEqual('');

			// Test URL redirection after the Skill was created
			expect($location.path()).toBe('/skills/' + sampleSkillResponse._id);
		}));

		it('$scope.update() should update a valid Skill', inject(function(Skills) {
			// Define a sample Skill put data
			var sampleSkillPutData = new Skills({
				_id: '525cf20451979dea2c000001',
				name: 'New Skill'
			});

			// Mock Skill in scope
			scope.skill = sampleSkillPutData;

			// Set PUT response
			$httpBackend.expectPUT(/skills\/([0-9a-fA-F]{24})$/).respond();

			// Run controller functionality
			scope.update();
			$httpBackend.flush();

			// Test URL location to new object
			expect($location.path()).toBe('/skills/' + sampleSkillPutData._id);
		}));

		it('$scope.remove() should send a DELETE request with a valid skillId and remove the Skill from the scope', inject(function(Skills) {
			// Create new Skill object
			var sampleSkill = new Skills({
				_id: '525a8422f6d0f87f0e407a33'
			});

			// Create new Skills array and include the Skill
			scope.skills = [sampleSkill];

			// Set expected DELETE response
			$httpBackend.expectDELETE(/skills\/([0-9a-fA-F]{24})$/).respond(204);

			// Run controller functionality
			scope.remove(sampleSkill);
			$httpBackend.flush();

			// Test array after successful delete
			expect(scope.skills.length).toBe(0);
		}));
	});
}());