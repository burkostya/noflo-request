chai = require 'chai' unless chai
expect = chai.expect  if chai

request = require 'superagent'

noflo  = require 'noflo'
socket = noflo.internalSocket
# unless noflo.isBrowser()
#   graphData = fs.readFileSync "#{__dirname}/../graphs/SetRequestQuery.fbp",
#                               encoding: 'utf8'
# else
#   SetRequestQuery = require 'noflo-request/graphs/SetRequestQuery.js'

loader = new noflo.ComponentLoader require('path').resolve(__dirname, '..')

describe 'SetRequestQuery component', ->
  remoteUrl  = 'http://localhost:4000'

  c = null
  ins = null
  req = null
  out = null
  beforeEach (done) ->
    loader.load 'request/SetRequestQuery', (instance) ->
      instance.once 'ready', () ->
        c = instance
        ins = socket.createSocket()
        req = socket.createSocket()
        out = socket.createSocket()
        c.inPorts.in.attach ins
        c.inPorts.request.attach req
        c.outPorts.out.attach out
        done()

  describe 'when instantiated', ->
    it 'should have an in port', ->
      expect(c.inPorts.in).to.be.an 'object'
    it 'should have an request port', ->
      expect(c.inPorts.request).to.be.an 'object'
    it 'should have an out port', ->
      expect(c.outPorts.out).to.be.an 'object'
  describe 'when given query and `request` object', ->
    it.only 'should apply query to `request` object and send it to out port', (done) ->
        out.on 'data', (data) ->
          console.log data.req.path
          # expect(data.req.path).to.equal '/?some=query&as=string'
          # done()
        req.send request('GET', remoteUrl)
        ins.send
          some: 'query'
        ins.send 'as=string'
        ins.disconnect()
