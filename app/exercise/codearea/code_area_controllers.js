// Generated by CoffeeScript 1.8.0
(function() {
  var JavaCodeController;

  JavaCodeController = (function() {
    function JavaCodeController($scope, $timeout, socketEndpointService) {
      var setupOptions;
      this.tab = "";
      setupOptions = {
        url: "localhost:3000",
        query: {
          query: "exerciseId=1"
        }
      };
      socketEndpointService.setUp(setupOptions);
      $scope.$on("destroy", function() {
        return socketEndpointService.tearDown();
      });
      socketEndpointService.output(function(resultObject) {
        if (resultObject.errors.length === 0) {
          return this.session.clearAnnotations();
        } else {
          return this.session.setAnnotations(resultObject.errors);
        }
      });
      this.aceOption = {
        mode: "java",
        onLoad: (function(_this) {
          return function(_ace) {
            _this.tab.editor = _ace;
            _this.session = _ace.getSession();
            return _ace.focus();
          };
        })(this),
        onChange: (function(_this) {
          return function(e) {
            var className, data, matches;
            data = e[0].data;
            if (data.action === "insertText" || data.action === "removeText") {
              socketEndpointService.input(_this.session.getValue(), 1000);
              matches = /(.*?)(?=\s+|$|extends|implements|\{)/m.exec(_this.session.getValue().replace(/([\n\r\s]*(public)+(\s|$)*)?(class|interface|@interface|enum)(\s|$)*/, ''));
              className = /[a-z\W\d_]/.test(matches[0][0]) ? "unbekannte Klasse" : "" + matches[0] + ".java";
              return _this.tab.title = className;
            }
          };
        })(this)
      };
    }

    JavaCodeController.prototype.editTab = function(tab) {};

    JavaCodeController.prototype.doneEditing = function(tab) {};

    JavaCodeController.prototype.removeTab = function() {
      return this.editor.destroy();
    };

    return JavaCodeController;

  })();

  angular.module("interactiveLecture.codeArea.controllers", ["interactiveLecture.codeArea.endPointServices"]).controller("JavaCodeController", ["$scope", "$timeout", "socketEndpointService", JavaCodeController]);

}).call(this);

//# sourceMappingURL=code_area_controllers.js.map