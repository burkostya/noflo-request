var http = require('http');

var socket = require('noflo').internalSocket;
var expect = require('chai').expect;

Get = require('../components/Get.js');

var server = http.createServer(function (req, res) {
  res.end([
    '<html>',
      '<head>',
      '</head>',
      '<body>',
      '</body>',
    '</html>'
  ].join(''));
});
var serverHost = 'http://localhost';
var serverPort = 3000;
server.listen(serverPort);

describe('Get component', function() {
  var c, ins, node, out, err;
  beforeEach(function() {
    c   = Get.getComponent();
    ins = socket.createSocket();
    out = socket.createSocket();
    err = socket.createSocket();
    c.inPorts.in.attach(ins);
    c.outPorts.out.attach(out);
    c.outPorts.error.attach(err);

    port         = socket.createSocket();
    localAddress = socket.createSocket();
    socketPath   = socket.createSocket();
    path         = socket.createSocket();
    headers      = socket.createSocket();
    auth         = socket.createSocket();
    agent        = socket.createSocket();
    c.inPorts.port.attach(port);
    c.inPorts.localAddress.attach(localAddress);
    c.inPorts.socketPath.attach(socketPath);
    c.inPorts.path.attach(path);
    c.inPorts.headers.attach(headers);
    c.inPorts.auth.attach(auth);
    c.inPorts.agent.attach(agent);
  });
  describe("when instantiated", function(){
    it("should have an input port", function(){
      expect(c.inPorts.in).to.be.an('object');
    });
    it("should have an output port", function(){
      expect(c.outPorts.out).to.be.an('object');
    });
    it("should have an error port", function(){
      expect(c.outPorts.error).to.be.an('object');
    });
    it("should have an port port", function(){
      expect(c.inPorts.port).to.be.an('object');
    });
    it("should have an localAddress port", function(){
      expect(c.inPorts.localAddress).to.be.an('object');
    });
    it("should have an socketPath port", function(){
      expect(c.inPorts.socketPath).to.be.an('object');
    });
    it("should have an path port", function(){
      expect(c.inPorts.path).to.be.an('object');
    });
    it("should have an headers port", function(){
      expect(c.inPorts.headers).to.be.an('object');
    });
    it("should have an auth port", function(){
      expect(c.inPorts.auth).to.be.an('object');
    });
    it("should have an agent port", function(){
      expect(c.inPorts.agent).to.be.an('object');
    });
  });
  describe("when receiving a url", function(){
    it("should send out response object", function(done){
      out.on('data', function (data) {
        expect(data).to.be.an('object');
        done();
      });
      err.on('data', function (error) {
        expect(error).to.not.exist;
      });
      ins.send(serverHost + ':' + serverPort);
    });
  });
});
