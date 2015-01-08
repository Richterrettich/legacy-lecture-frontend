courses = angular.module("interactiveLecture.courses",[])

courses.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->
  $stateProvider.state "courses",{
    url: "users/courses",
    templateUrl: 'users/courses/courses.html'
  }

  $stateProvider.state "courses.detail",{
    url: "/:courseId",
    templateUrl: 'users/courses/courses.details.html'
  }
]