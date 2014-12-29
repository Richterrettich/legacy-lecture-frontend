
class JavaCodeController
  constructor:($scope,$timeout,socketEndpointService)->
    #wird über ng-init initialisiert
    @tab = ""

    #TODO url auslesen für query
    #TODO socketurl mit config values festlegen
    setupOptions =
      url: "localhost:3000"
      query: {query:"exerciseId=1"}

    socketEndpointService.setUp(setupOptions)

    $scope.$on "destroy",()->
      socketEndpointService.tearDown()

    socketEndpointService.output (resultObject)->
      if resultObject.errors.length == 0
        @session.clearAnnotations()
      else
        @session.setAnnotations resultObject.errors

    #TODO hotkeys hinzufügen. command+s beispielsweise.
    @aceOption =
      mode: "java",
      onLoad: (_ace) =>
        @tab.editor=_ace
        @session = _ace.getSession()
        _ace.focus()
      onChange: (e)=>
        data = e[0].data
        if data.action == "insertText" || data.action == "removeText"
          socketEndpointService.input(@session.getValue(),1000)
          #TODO regular expression besser dokumentieren! Extraktion des Klassennamen... replace ist Ersatz für negativen Lookbehind. Umstrukturieren mit heregexes http://coffeescriptcookbook.com/chapters/regular_expressions/heregexes
          matches =  /(.*?)(?=\s+|$|extends|implements|\{)/m.exec(@session.getValue().replace(/([\n\r\s]*(public)+(\s|$)*)?(class|interface|@interface|enum)(\s|$)*/, ''))
          #keine Klassennamen akzeptieren, die mit Kleinbuchstaben,zahlen oder sonderzeichen anfangen
          className = if /[a-z\W\d_]/.test(matches[0][0])  then "unbekannte Klasse" else "#{matches[0]}.java"
          @tab.title = className

  # leere funktionen, da die tabüberschrift automatisch generiert wird.
  editTab :(tab)->
  doneEditing :(tab)->
  removeTab :()->
    @editor.destroy()





angular.module("interactiveLecture.codeArea.controllers",["interactiveLecture.codeArea.endPointServices"])
.controller "JavaCodeController",["$scope","$timeout","socketEndpointService",JavaCodeController]