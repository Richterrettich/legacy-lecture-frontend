// Generated by CoffeeScript 1.8.0
(function() {
  var courses;

  courses = angular.module("interactiveLecture.courses", []);

  courses.config([
    "$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider) {
      $stateProvider.state("courses", {
        url: "/courses",
        templateUrl: 'courses/courses.html'
      });
      return $stateProvider.state("courses.detail", {
        url: "/:courseId",
        templateUrl: 'courses/courses.details.html'
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=courses.js.map