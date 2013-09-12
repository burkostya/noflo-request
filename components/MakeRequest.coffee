noflo = require 'noflo'

request = require 'superagent'

Port      = noflo.Port
Component = noflo.Component

class MakeRequest extends Component
  constructor: ->
    @method = 'GET'

    @inPorts =
      url:    new Port
      method: new Port
    @outPorts =
      out: new Port

    @inPorts.method.on 'data', (@method) =>

    @inPorts.url.on 'data', (url) =>
      @outPorts.out.send request(@method, url)

    @inPorts.url.on 'disconnect', () =>
      @outPorts.out.disconnect()

exports.getComponent = -> new MakeRequest