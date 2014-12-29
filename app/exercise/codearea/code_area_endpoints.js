// Generated by CoffeeScript 1.8.0
(function() {
  var SocketEndPoint, endpoint;

  endpoint = angular.module("interactiveLecture.codeArea.endPointServices", []);

  SocketEndPoint = (function() {
    function SocketEndPoint($timeout) {
      this.timeout = $timeout;
      this.data = [];
      this.timeoutPromise = null;
    }

    SocketEndPoint.prototype.setUp = function(options) {
      return this.socket = io.connect(options.url, options.query);
    };

    SocketEndPoint.prototype.input = function(data, delay) {
      if (delay != null) {
        if (this.timeoutPromis) {
          this.timeout.cancel(this.timeoutPromis);
        }
        return this.timeoutPromis = this.timeout(((function(_this) {
          return function() {
            return _this.socket.emit("inputData", data);
          };
        })(this)), delay);
      } else {
        return this.socket.emit("inputData", data);
      }
    };

    SocketEndPoint.prototype.output = function(callback) {
      if (callback == null) {
        callback = (function(_this) {
          return function(data) {
            return _this.data = JSON.parse(data);
          };
        })(this);
      }
      return this.socket.on('result', function(data) {
        var resultObject;
        resultObject = {};
        if (typeof data === "string") {
          resultObject = JSON.parse(data);
        } else if (typeof data === "object") {
          resultObject = data;
        } else {
          throw new Error("illegal service output data type");
        }
        return callback(resultObject);
      });
    };

    SocketEndPoint.prototype.tearDown = function() {
      return this.socket.disconnect();
    };

    return SocketEndPoint;

  })();

  endpoint.service("socketEndpointService", ["$timeout", SocketEndPoint]);

}).call(this);

//# sourceMappingURL=code_area_endpoints.js.map
