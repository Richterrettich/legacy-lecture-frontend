// Generated by CoffeeScript 1.8.0
(function() {
  var exercise;

  exercise = angular.module("interactiveLecture.exercise", []);

  exercise.config([
    "$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider) {
      $stateProvider.state("exercise", {
        abstract: true,
        url: "/courses/:courseId/chapters/:chapterId/sections/:sectionId/exercise/:exerciseId",
        template: "<ui-view></ui-view>",
        resolve: {
          courseId: [
            '$stateParams', function($stateParams) {
              return $stateParams.courseId;
            }
          ],
          chapterId: [
            '$stateParams', function($stateParams) {
              return $stateParams.chapterId;
            }
          ],
          sectionId: [
            '$stateParams', function($stateParams) {
              return $stateParams.sectionId;
            }
          ],
          exerciseId: [
            '$stateParams', function($stateParams) {
              return $stateParams.exerciseId;
            }
          ]
        }
      });
      return $stateProvider.state("exercise.code", {
        url: "/code",
        templateUrl: "exercise/exercise.code.html"
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=exercise.js.map
