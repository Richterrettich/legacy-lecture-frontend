exercise = angular.module("interactiveLecture.exercise",[])

exercise.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->

  $stateProvider.state "exercise",{
    abstract:true
    url: "/courses/:courseId/chapters/:chapterId/sections/:sectionId/exercise/:exerciseId",
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
      ],
      exerciseId:['$stateParams',($stateParams)->
        return $stateParams.exerciseId
      ]
    }
  }


  $stateProvider.state "exercise.code",{
    url: "/code",
    templateUrl:"exercise/exercise.code.html"
  }
]