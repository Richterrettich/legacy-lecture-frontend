chapters = angular.module("interactiveLecture.chapters",[])

chapters.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->
  $stateProvider.state "chapters",{
    url: "/courses/:courseId/chapters",
    templateUrl: 'chapters/chapters.html'
  }

  $stateProvider.state "chapters.detail",{
    url: "/:chapterId",
    templateUrl: 'courses/courses.details.html'
  }
]