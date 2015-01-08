// Generated by CoffeeScript 1.8.0
(function() {
  var app, exerciseId, express, http, io, router;

  express = require("express");

  app = express();

  router = express.Router();

  http = require('http').Server(app);

  io = require('socket.io')(http);

  app.use(express["static"](__dirname + '/'));

  exerciseId = "";

  io.use(function(socket, next) {
    exerciseId = socket.request._query.exerciseId;
    console.log(socket.request._query);
    return next();
  });

  io.on('connection', function(socket) {
    var CompileService, compileService;
    CompileService = require("./compile_service");
    compileService = new CompileService(exerciseId);
    socket.on('exerciseCode', function(code) {
      console.log("got code! " + code);
      return compileService.compileExercises(code, function(compilationResult) {
        console.log("this is the result: " + compilationResult);
        return socket.emit('exerciseCompilationResult', compilationResult);
      });
    });
    socket.on('testCode', function(code) {
      return compileService.compileTests(code, function(compilationResult) {
        return socket.emit('testCompilationResult', compilationResult);
      });
    });
    return socket.on('submit', function() {
      return compileService.startTests(function(testResult) {
        return socket.emit('testResult', testResult);
      });
    });
  });

  http.listen(3000, function() {
    return console.log('listening on *:3000');
  });

}).call(this);

//# sourceMappingURL=server.js.map
