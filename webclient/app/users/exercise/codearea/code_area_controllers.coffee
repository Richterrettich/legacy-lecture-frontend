
class JavaController
  constructor:(@socketEndpointService)->

    #socketEndpointService.setUp(url:"http://localhost:3000",options:{query:"exerciseId=#{$scope.exerciseId}&chapterId=#{$scope.chapterId}&courseId=#{$scope.courseId}"},inputEventName:"exerciseCode",resultEventName:"exerciseCompilationResult")
    #TODO this is the result: {"errors":[{"row":0,"column":12,"text":"reached end of file while parsing","type":"error"}]} untersuchen. vielleicht(wahrscheinlich) im backend.



  # leere funktionen, da die tabüberschrift automatisch generiert wird.
  editTab :()->

  doneEditing :()->

  setTab:(tab)->
    @tab = tab
    #TODO hotkeys hinzufügen. command+s beispielsweise.
    @tab.setOnChangeListener (e)=>
      data = e[0].data
      if data.action == "insertText" || data.action == "removeText"
        codeObject = {id:tab.id,code:tab.content}
        @socketEndpointService.input(codeObject,1000)
        #TODO regular expression besser dokumentieren! Extraktion des Klassennamen... replace ist Ersatz für negativen Lookbehind. Umstrukturieren mit heregexes http://coffeescriptcookbook.com/chapters/regular_expressions/heregexes
        matches =  /(.*?)(?=\s+|$|extends|implements|\{)/m.exec(tab.content.replace(/([\n\r\s]*(public)+(\s|$)*)?(class|interface|@interface|enum)(\s|$)*/, ''))
        #keine Klassennamen akzeptieren, die mit Kleinbuchstaben,zahlen oder sonderzeichen anfangen
        className = if /[a-z\W\d_]/.test(matches[0][0])  then "unbekannte Klasse" else "#{matches[0]}.java"
        @tab.title = className






angular.module("interactiveLecture.codeArea.controllers",["interactiveLecture.codeArea.endPointServices"])
.controller "JavaController",["socketEndpointService",JavaController]