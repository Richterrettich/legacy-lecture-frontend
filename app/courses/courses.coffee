courses = angular.module("interactiveLecture.courses",[])

courses.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->
  $stateProvider.state "courses",{
    url: "/courses",
    templateUrl: 'courses/courses.html'
  }

  $stateProvider.state "courses.detail",{
    url: "/:courseId",
    templateUrl: 'courses/courses.details.html'
  }
]