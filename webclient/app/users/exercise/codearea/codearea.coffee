'use strict'
app = angular.module("interactiveLecture.codeArea",['ui.ace','ui.bootstrap',"interactiveLecture.codeArea.controllers","interactiveLecture.codeTabServices"])

###*
  # @ngdoc directive
###
app.directive "codeArea",()->
  return {
    restrict:"E",
    templateUrl: "users/exercise/codearea/codearea.html",
    require:["endpointService","endpointServiceConfiguration"],
    scope:{
      endpointService:"@endpointService",
      endpointServiceConfiguration:"=endpointServiceConfiguration"
    }
    controller: CodeAreaMainCtrl,
    controllerAs: 'codeAreaMainCtrl'
  }

CodeAreaMainCtrl = ["$scope","$timeout","$injector","$controller","$modal","tabListService", ($scope,$timeout,$injector,$controller,$modal,tabListService)->


  #damit es für die geladenen controller einfacher wird an die url-parameter zu kommen.
  $scope.language = $scope.$parent.language
  $scope.exerciseId = $scope.$parent.exerciseId
  $scope.courseId = $scope.$parent.courseId
  $scope.chapterId = $scope.$parent.chapterId
  $scope.sectionId = $scope.$parent.sectionId


  #dynamic endpoint service injection
  endpoint = $injector.get($scope.endpointService)
  endpoint.setUp($scope.endpointServiceConfiguration)

  endpoint.registerResultHandler (resultObject)=>
    errorTabIds = []
    if resultObject.errors.length >0
      $scope.$emit("errors")
      resultObject.errors.forEach (err)->
        errorTabIds.push(err.tabId)
        #TODO Uncaught TypeError: Cannot read property 'addError' of undefined... tritt auf, wenn keine gültige KLasse erstellt wurde. vielleicht schon vorher abfangen
        tabListService.addAnnotation(err.tabId,err)
      Object.keys(@tabs).forEach (k)=>
        if errorTabIds.indexOf(parseInt(k)) == -1
          @tabs[k].clearAnnotations()
    else
      tabListService.clearAnnotations()
      $scope.$emit("no-errors")


  $scope.$on "destroy",()->
    tabListService.removeAllTabs()
    endpoint.tearDown()

  tabController = "#{$scope.language.capitalize()}Controller"



  @tabs = tabListService.tabs


  @addTab = ()->
    t = tabListService.addTab($scope.language)
    # dynamic controller injection
    t.setTabController($controller(tabController,{$scope:$scope.$new()}))
    console.log(@tabs)

  @addTab($scope.language)

  @getTab= (id)->
    tabListService.getTab(id)

  @removeTab=(tab,event)->
    event.preventDefault()
    modalInstance = $modal.open {
      templateUrl: 'users/exercise/codearea/delete-modal-template.html',
      controller: 'DeleteModalController',
      size: "sm"
    }
    modalInstance.result.then (closeResult) =>
      if closeResult=='ok'
        if Object.keys(tabListService.tabs).length > 1
          tabListService.removeTab(tab.id)
        else
          tabListService.clearTab(tab.id)
]

app.controller "DeleteModalController",["$scope","$modalInstance",($scope,$modalInstance)->
  $scope.ok=()->
    $modalInstance.close("ok")

  $scope.cancel=()->
    $modalInstance.dismiss('cancel')

]