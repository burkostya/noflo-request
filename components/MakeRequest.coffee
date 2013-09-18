noflo = require 'noflo'

request = require 'superagent'

Port      = noflo.Port
Component = noflo.Component

class MakeRequest extends Component
  constructor: ->
    @method = 'GET'

    @inPorts =
      in:    new Port 'string'
      method: new Port 'string'
    @outPorts =
      out: new Port 'object'

    @inPorts.method.on 'data', (@method) =>

    @inPorts.in.on 'data', (url) =>
      @outPorts.out.send request(@method, url)

    @inPorts.in.on 'disconnect', () =>
      @outPorts.out.disconnect()

exports.getComponent = -> new MakeRequest