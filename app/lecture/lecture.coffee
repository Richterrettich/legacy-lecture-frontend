lectures = angular.module("interactiveLecture.lectures")

lectures.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->

  $stateProvider.state "lecture",{
    abstract:true
    url: "/courses/:courseId/chapters/:chapterId/sections/:sectionId/lecture",
    template:"<ui-view></ui-view>"
    resolve:{
      courseId:['$stateParams',($stateParams)->
        return $stateParams.courseId
      ],
      chapterId:['$stateParams',($stateParams)->
        return $stateParams.chapterId
      ],
      sectionId:['$stateParams',($stateParams)->
        return $stateParams.sectionId
      ]
    }
  }


  $stateProvider.state "lecture.text",{
    abstract:true
    url: "/text",
    templateUrl:"lecture/lecture.text.html"
  }

  $stateProvider.state "lecture.video",{
    abstract:true
    url: "/text",
    templateUrl:"lecture/lecture.video.html"
  }
]

