'use strict';
app = angular.module 'interactiveLecture', ['interactiveLecture.codeArea',"ui.router"]



app.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->
  $stateProvider.state "courses",{
    url: "/courses",
    templateUrl: 'courses/courses.html'
  }

  $stateProvider.state "courses.detail",{
    url: "/:courseId",
    templateUrl: 'courses/courses.details.html'
  }

  ###$stateProvider.state "courses.detail",{
    url: "/courses/:courseId",
    templateUrl: 'courses/courses.details.html'
  }###
]