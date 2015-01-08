chapters = angular.module("interactiveLecture.chapters",[])

chapters.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->
  $stateProvider.state "chapters",{
    url: "users/courses/:courseId/chapters",
    templateUrl: 'users/chapters/chapters.html'
  }

  $stateProvider.state "chapters.detail",{
    url: "/:chapterId",
    templateUrl: 'users/chapters/chapters.details.html'
  }
]