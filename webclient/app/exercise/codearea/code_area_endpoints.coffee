# folgt dem endpoint interface
endpoint = angular.module("interactiveLecture.codeArea.endPointServices",[])

class SocketEndPoint
  constructor:($timeout)->
    @timeout=$timeout
    @data=[]
    @timeoutPromise = null

  setUp: (options)->
    @socket = io.connect(options.url,options.query)

  input:(data,delay)->
    if delay?
      @timeout.cancel(@timeoutPromis) if @timeoutPromis
      @timeoutPromis = @timeout (()=>  @socket.emit("inputData",data)),delay
    else
      @socket.emit("inputData",data)

  output:(callback)->
    unless callback?
      callback = (data)=>
        @data = JSON.parse(data)
    @socket.on 'result',(data)->
      resultObject = {}
      if typeof data is "string"
        resultObject = JSON.parse(data)
      else if typeof data is "object"
        resultObject = data
      else
        throw new Error("illegal service output data type")
      callback(resultObject)

  tearDown:()->
    @socket.disconnect()

endpoint.service "socketEndpointService",["$timeout",SocketEndPoint]
