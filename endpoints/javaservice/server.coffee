express = require("express")
app = express()
router = express.Router()
http = require('http').Server(app);
io = require('socket.io')(http);
#app.get '/', (req, res)->
#  res.sendFile 'index.html',  { root: __dirname }

app.use(express.static(__dirname + '/'));

#router.param "id", (req,resp,next,id)->
#  req.params.id =id
#  console.log("url is #{req.originalUrl}")
#  next()

#router.use "/exercises/:id/tests", require("./test_module")(router)
###router.get "/exercises/:id/tests/results",(req,resp)->
  id = req.params.id
  console.log("GET: #{id}")

router.post "/exercises/:id/tests", (req,resp)->
  id= req.params.id
  console.log("POST: #{id}")

app.use router###


exerciseId = ""
io.use (socket, next) ->
  exerciseId = socket.request._query.exerciseId
  console.log("in io.use exerciseId: #{exerciseId}")
  #TODO hier das laden der tests initiieren
  #make sure the handshake data looks good as before
  #if error do this:
  #next(new Error('not authorized');
  #else just call next
  next();
io.on 'connection', (socket)->
  CompileService = require("./compile_service")
  compileService = new CompileService(exerciseId)
  socket.on 'exerciseCode', (code)->
    console.log("got code! #{code}")
    compileService.compileExercises code,(compilationResult)->
      console.log("this is the result: #{compilationResult}")
      socket.emit('exerciseCompilationResult', compilationResult)

  socket.on 'testCode', (code)->
    compileService.compileTests code,(compilationResult)->
        socket.emit('testCompilationResult', compilationResult);

  socket.on 'submit', ()->
    compileService.startTests (testResult)->
        socket.emit('testResult', testResult);
http.listen 3000, ()->
  console.log('listening on *:3000');
