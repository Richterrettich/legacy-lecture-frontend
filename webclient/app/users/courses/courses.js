// Generated by CoffeeScript 1.8.0
(function() {
  var CoursesController, courses;

  courses = angular.module("interactiveLecture.courses", []);


  /*
    @ngdoc controller
   */

  CoursesController = (function() {
    function CoursesController($scope) {
      $scope.courses = [
        {
          courseId: 1,
          title: "Grundlagen Programmierung"
        }, {
          courseId: 2,
          title: "Programmierung"
        }
      ];
      console.log("hier");
    }

    return CoursesController;

  })();

  courses.config([
    "$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider) {
      $stateProvider.state("courses", {
        url: "users/courses",
        templateUrl: 'users/courses/courses.html',
        controller: ["$scope", CoursesController]
      });
      return $stateProvider.state("courses.detail", {
        url: "/:courseId",
        templateUrl: 'users/courses/courses.details.html'
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=courses.js.map
