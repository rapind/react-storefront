List = require('./list.coffee')
Detail = require('./detail.coffee')

{div} = React.DOM

App = React.createClass
  render: ->
    div { className: "row" },
      div { className: "col-xs-3" },
        List {}
      div { className: "col-xs-9" },
        Detail {}
      Router.RouteHandler

module.exports = App
