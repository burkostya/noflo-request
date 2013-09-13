noflo = require 'noflo'

Port      = noflo.Port
Component = noflo.AsyncComponent

class SendRequest extends Component
  constructor: ->
    @inPorts =
      in:    new Port 'object'
    @outPorts =
      out:   new Port 'object'
      error: new Port 'object'
    super()

  doAsync: (req, done) ->
    req.end (err, res) =>
      return done err if err
      @outPorts.out.send res
      done()

exports.getComponent = -> new SendRequest