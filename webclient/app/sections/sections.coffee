sections = angular.module("interactiveLecture.sections",[])

sections.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->

  $stateProvider.state "sections",{
    abstract:true
    url: "/courses/:courseId/chapters/:chapterId/sections/:sectionId",
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



  $stateProvider.state "sections.lecture",{
    abstract:true
    url: "/lecture",
    templateUrl: 'sections/courses.details.html'
  }
]