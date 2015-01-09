// Generated by CoffeeScript 1.8.0
(function() {
  var CodeTab, CodeTabs, codeTabServices;

  codeTabServices = angular.module("interactiveLecture.codeTabServices", []);

  CodeTab = (function() {
    function CodeTab(language, id) {
      this.language = language;
      this.id = id;
      this.active = true;
      this.focus = true;
      this.editing = false;
      this.title = "Neue Datei";
      this.content = "";
      this.errors = [];
      this.tabController = {};
      this.aceOption = {
        mode: this.language,
        onLoad: (function(_this) {
          return function(_ace) {
            _this.editor = _ace;
            return _ace.focus();
          };
        })(this)
      };
    }

    CodeTab.prototype.clearAnnotations = function() {
      return this.editor.getSession().clearAnnotations();
    };

    CodeTab.prototype.addError = function(err) {
      if (err != null) {
        this.errors.push(err);
        return this.editor.getSession().setAnnotations(this.errors);
      } else {
        this.errors = [];
        return this.editor.getSession().clearAnnotations();
      }
    };

    CodeTab.prototype.setOnChangeListener = function(callback) {
      return this.aceOption.onChange = callback;
    };

    CodeTab.prototype.clear = function() {
      this.content = "";
      return this.title = "Neue Datei";
    };

    CodeTab.prototype.setTabController = function(controller) {
      controller.setTab(this);
      return this.tabController = controller;
    };

    return CodeTab;

  })();

  CodeTabs = (function() {
    function CodeTabs() {
      this.id = 0;
      this.tabs = {};
    }

    CodeTabs.prototype.addTab = function(language) {
      var t;
      t = new CodeTab(language, this.id);
      this.tabs[this.id++] = t;
      return t;
    };

    CodeTabs.prototype.removeTab = function(tabId) {
      return delete this.tabs[tabId];
    };

    CodeTabs.prototype.clearAnnotations = function() {
      return angular.forEach(this.tabs, function(tab) {
        return tab.clearAnnotations();
      });
    };

    CodeTabs.prototype.addAnnotation = function(tabId, err) {
      return this.tabs[tabId].addError(err);
    };

    CodeTabs.prototype.clearTab = function(tabId) {
      return this.tabs[tabId].clear();
    };

    CodeTabs.prototype.removeAllTabs = function() {
      return this.tabs = {};
    };

    return CodeTabs;

  })();

  codeTabServices.service("tabListService", [CodeTabs]);

}).call(this);

//# sourceMappingURL=code_tab_services.js.map