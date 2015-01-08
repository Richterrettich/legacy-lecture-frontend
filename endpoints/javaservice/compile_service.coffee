java = require("java");
java.classpath.push("/Users/renerichter/NetBeansProjects/Java-Runtime-Compiler/JavaExecutionService/target/JavaExecutionService-1.0-SNAPSHOT-jar-with-dependencies.jar");

AppFacade = java.import "com.lecture.app.AppFacade"


class CompileService
  constructor:  (exerciseId)->
    @facade = new AppFacade(exerciseId)
  compileExercises: (codeObject,callback)=>
    @facade.compileSourceForErrorJson(codeObject.id,codeObject.code,AppFacade.Scope.EXERCISE,(err,compilationResult)->
      callback(compilationResult))
  compileTests : (codeObject,callback)=>
    @facade.compileSourceForErrorJson(codeObject.id,codeObject.code,AppFacade.Scope.TEST (err,compilationResult)->
        callback(compilationResult))
  startTests:(callback)=>
    @facade.executeTestsForFailureJson (err,failures)->
      callback(failures)

module.exports = CompileService
