courses = angular.module("interactiveLecture.courses",[])


class CoursesController
  constructor:($scope)->
    $scope.courses = [{courseId:1,title:"Grundlagen Programmierung"},{courseId:2,title:"Programmierung"}]




courses.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->
  $stateProvider.state "courses",{
    url: "users/courses",
    templateUrl: 'users/courses/courses.html',
    controller:["$scope",CoursesController]

  }

  $stateProvider.state "courses.detail",{
    url: "/:courseId",
    templateUrl: 'users/courses/courses.details.html'
  }
]