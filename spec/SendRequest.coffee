chai = require 'chai' unless chai
expect = chai.expect  if chai

request = require 'superagent'

noflo  = require 'noflo'
socket = noflo.internalSocket
unless noflo.isBrowser()
  SendRequest = require '../components/SendRequest.coffee'
else
  SendRequest = require 'noflo-request/components/SendRequest.js'

describe 'SendRequest component', ->
  remoteUrl  = 'http://localhost:4000/test.html'
  requestObj = null

  c = null
  reqSock = null
  resSock = null
  error   = null
  beforeEach () ->
    c = SendRequest.getComponent()
    reqSock = socket.createSocket()
    resSock = socket.createSocket()
    error   = socket.createSocket()
    c.inPorts.in.attach reqSock
    c.outPorts.out.attach resSock
    c.outPorts.error.attach error

  describe 'when instantiated', ->
    it 'should have an in port', ->
      expect(c.inPorts.in).to.be.an 'object'
    it 'should have an out port', ->
      expect(c.outPorts.out).to.be.an 'object'
    it 'should have an error port', ->
      expect(c.outPorts.error).to.be.an 'object'
  describe 'when given request object', ->
    msg  = '<html><head></head><body>seems to work</body></html>'
    it 'should send response object to out port', (done) ->
      resSock.on 'data', (data) ->
        expect(data).to.be.an 'object'
        expect(data.text).to.equal msg
        done()
      reqSock.send request.get remoteUrl
    it 'should send error to `error` port if present', (done) ->
      error.on 'data', (data) ->
        expect(data).to.be.an 'object'
        done()
      reqSock.send request.get 'http://localhost:3001'
