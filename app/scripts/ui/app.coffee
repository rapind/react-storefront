List = require('./list.coffee')
Detail = require('./detail.coffee')

{div} = React.DOM

App = React.createClass
  getInitialState: ->
    { products: [] }

  loadData: ->
    # console.log 'load data for list'
    $.ajax(
      url: '/data/list.json'
      dataType: 'json'
      success: (data) =>
        # console.log "list data:", data
        @setState { products: data.products }
      error: () ->
        console.log 'Error loading data'
    )

  componentWillMount: ->
    @loadData()

  render: ->
    div { className: "row" },
      div { className: "col-xs-3" },
        List { products: @state.products }
      div { className: "col-xs-9" },
        Router.RouteHandler { products: @state.products }

module.exports = App
