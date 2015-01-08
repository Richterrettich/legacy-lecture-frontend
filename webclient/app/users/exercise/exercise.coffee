exercise = angular.module("interactiveLecture.exercise",[])


class ExerciseController
  constructor:(@scope)->
    @scope.hasErrors=false
    @scope.$on "errors" ,(data)=>
      console.log("got error event")
      @scope.hasErrors=true
      @scope.$apply();
    @scope.$on "no-errors",(data)=>
      console.log("got no-error event")
      @scope.hasErrors=false
      @scope.$apply();


class ExerciseCodeController
  constructor:($scope, $stateParams, courseId, chapterId, sectionId, exerciseId)->
    $scope.language = $stateParams.language
    $scope.courseId = courseId
    $scope.chapterId = chapterId
    $scope.sectionId = sectionId
    $scope.exerciseId = exerciseId





exercise.config ["$stateProvider", "$urlRouterProvider",($stateProvider, $urlRouterProvider)->

  $stateProvider.state "exercise",{
    abstract:true
    url: "/courses/:courseId/chapters/:chapterId/sections/:sectionId/exercise/:exerciseId",
    templateUrl:"exercise/exercise.html"
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
    controller:["$scope",ExerciseController]
  }


  $stateProvider.state "exercise.code",{
    url: "/code/:language",
    templateUrl:"exercise/exercise.code.html"
    controller: ["$scope","$stateParams","courseId","chapterId","sectionId","exerciseId", ExerciseCodeController]
  }
]

