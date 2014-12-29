java = require("java");
java.classpath.push("/Users/renerichter/NetBeansProjects/Java-Runtime-Compiler/JavaExecutionService/target/JavaExecutionService-1.0-SNAPSHOT-jar-with-dependencies.jar");

AppFacade = java.import "com.lecture.app.AppFacade"


class CompileService
  constructor:  (exerciseId)->
    @facade = new AppFacade(exerciseId)
  compileExercises: (sourceCode,callback)=>
    @facade.compileSourceForErrorJson(sourceCode,AppFacade.Scope.EXERCISE,(err,compilationResult)->
      callback(compilationResult))
  compileTests : (sourceCode,callback)=>
    @facade.compileSourceForErrorJson(sourceCode,AppFacade.Scope.TEST (err,compilationResult)->
        callback(compilationResult))
  startTests:(callback)=>
    @facade.executeTestsForFailureJson (err,failures)->
      callback(failures)

module.exports = CompileService
