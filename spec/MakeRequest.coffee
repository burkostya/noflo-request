noflo  = require 'noflo'
socket = noflo.internalSocket
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  expect = chai.expect
  MakeRequest = require '../components/MakeRequest.coffee'
else
  MakeRequest = require 'noflo-request/components/MakeRequest.js'

describe 'MakeRequest component', ->
  remotePort = 3000
  remoteUrl  = 'http://localhost:' + remotePort

  c = null
  url    = null
  method = null
  out    = null
  beforeEach ->
    c = MakeRequest.getComponent()
    url    = socket.createSocket()
    method = socket.createSocket()
    out    = socket.createSocket()
    c.inPorts.url.attach url
    c.inPorts.method.attach method
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have an url port', ->
      expect(c.inPorts.url).to.be.an 'object'
    it 'should have an method port', ->
      expect(c.inPorts.method).to.be.an 'object'
    it 'should have an output port', ->
      expect(c.outPorts.out).to.be.an 'object'
  describe 'when given url', ->
    it 'should send request object to out port', (done) ->
        out.on 'data', (data) ->
          expect(data).to.be.an 'object'
          done()
        url.send remoteUrl
    describe 'and method', ->
      it 'should send request object with specified method', (done) ->
        out.on 'data', (data) ->
          expect(data.method).to.equal 'POST'
          done()
        method.send 'POST'
        url.send remoteUrl
    describe 'but not method', ->
      it 'should use GET method', (done) ->
        out.on 'data', (data) ->
          expect(data.method).to.equal 'GET'
          done()
        url.send remoteUrl