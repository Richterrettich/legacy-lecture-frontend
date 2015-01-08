# folgt dem endpoint interface
endpoint = angular.module("interactiveLecture.codeArea.endPointServices",[])

class SocketEndPoint
  constructor:(@timeout)->
    @resultHandlers = []
    @timeoutPromise = null

  registerResultHandler:(handler)->
    @resultHandlers.push(handler)

  setUp: ({url,options,inputEventName,resultEventName} = {})->
    throw new Erorr("socket already up and running! you need to call tearDown first.") if @socket?
    @inputEventName = inputEventName || "inputData"
    @resultEventName = resultEventName || "result"
    if url and options
      @socket = io.connect(url,options)
    else if url
      @socket = io.connect(url)
    else if options
      @socket = io.connect(null,options)
    else
      @socket = io.connect()
    @socket.on @resultEventName,(data)=>
      resultObject = {}
      if typeof data is "string"
        resultObject = JSON.parse(data)
      else if typeof data is "object"
        resultObject = data
      else
        throw new Error("illegal service output data type")
      angular.forEach @resultHandlers,(handler)->
        handler(resultObject)



  input:(data,delay)->
    if delay? and delay > 0
      @timeout.cancel(@timeoutPromis) if @timeoutPromis
      @timeoutPromis = @timeout (()=>  @socket.emit(@inputEventName,data)),delay
    else
      @socket.emit("inputData",data)

  tearDown:()->
    @socket.disconnect()
    @socket = null

endpoint.service "socketEndpointService",["$timeout",SocketEndPoint]
