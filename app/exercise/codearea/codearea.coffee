'use strict'
app = angular.module("interactiveLecture.codeArea",['ui.ace','ui.bootstrap',"interactiveLecture.codeArea.controllers"])

app.directive "codeArea",()->
  return {
    restrict:"E",
    templateUrl: "/codearea.html",

    require: ["tabController"]
    scope:{
      tabController:'@'
    }
    controller: CodeAreaMainCtrl,
    controllerAs: 'codeAreaMainCtrl'
  }



CodeAreaMainCtrl = ["$scope","$timeout","$injector","$controller","$modal", ($scope,$timeout,$injector,$controller,$modal)->


  @addTab = ()->
    @tabs.push({title:"Neue Klasse",active:true,focus:true,editing:false})
  @tabs = [{title:"Neue Klasse",active:true}]


  # dynamic controller injection
  $scope.tabCtrl=$controller($scope.tabController,{$scope:$scope.$new()})


  @removeTab=($index,event)->
    event.preventDefault()
    modalInstance = $modal.open {
      templateUrl: '/delete-modal-template.html',
      controller: 'DeleteModalController',
      size: "sm"
    }
    modalInstance.result.then (closeResult) =>
      if closeResult=='ok'
        @tabs[$index].editor.destroy()
        @tabs.splice($index,1)
]

app.controller "DeleteModalController",["$scope","$modalInstance",($scope,$modalInstance)->
  $scope.ok=()->
    $modalInstance.close("ok")

  $scope.cancel=()->
    $modalInstance.dismiss('cancel')

]