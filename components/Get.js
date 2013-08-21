var util = require('util');
var http = require('http');

var noflo     = require('noflo');
var Port      = noflo.Port;
var Component = noflo.Component;

var Get = function() {
  var self = this;

  self.inPorts = {
    in:           new Port('string'),
    port:         new Port('number'),
    localAddress: new Port('string'),
    socketPath:   new Port('string'),
    path:         new Port('string'),
    headers:      new Port('object'),
    auth:         new Port('string'),
    agent:        new Port('all')
  };
  self.outPorts = {
    out:   new Port('string'),
    error: new Port('string')
  };

  Component.call(self);

  self._options = null;

  self.inPorts.in.on('data', function (hostname) {
    var options = self._options;
    if (!options) {
      options = hostname;
    } else {
      options.hostname = hostname;
    }
    var req = http.get(options, function (res) {
      self.outPorts.out.send(res);
      self.outPorts.out.disconnect();
    });
    req.on('error', function (err) {
      self.outPorts.out.disconnect();
      self.outPorts.error.send(err);
      self.outPorts.error.disconnect();
    });
  });
};

util.inherits(Get, Component);

exports.getComponent = function() {
  return new Get();
};
