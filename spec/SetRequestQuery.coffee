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
  ins   = null
  query = null
  out   = null
  beforeEach (done) ->
    loader.load 'request/SetRequestQuery', (instance) ->
      instance.once 'ready', () ->
        c = instance
        ins   = socket.createSocket()
        query = socket.createSocket()
        out   = socket.createSocket()
        c.inPorts.in.attach ins
        c.inPorts.query.attach query
        c.outPorts.out.attach out
        done()

  describe 'when instantiated', ->
    it 'should have an in port', ->
      expect(c.inPorts.in).to.be.an 'object'
    it 'should have an query port', ->
      expect(c.inPorts.query).to.be.an 'object'
    it 'should have an out port', ->
      expect(c.outPorts.out).to.be.an 'object'
  describe 'when given query and `request`', ->
    it.only 'should apply query to `request` object and send it to out port', (done) ->
        out.on 'data', (data) ->
          expect(data.req.path).to.equal '/?some=query'
          done()
        query.send some: 'query'
        ins.send request('GET', remoteUrl)