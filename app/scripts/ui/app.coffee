{div, a, p, ul, li} = React.DOM

App = React.createClass
  getInitialState: ->
    { affiliate_id: "", categories: [], products: [] }

  componentWillMount: ->
    @loadData()

  loadData: ->
    console.log 'load data'
    $.ajax(
      url: @props.dataUrl
      dataType: 'json'
      success: (data) =>
        console.log "data", data
        @setState { affiliate_id: data.affiliate_id, categories: data.categories, products: data.products }
      error: () ->
        console.log 'Error loading data'
    )

  render: ->
    List { products: @state.products }

List = React.createClass
  render: ->
    ul {},
      _.each(@props.products, (product) ->
        li { className: 'list-group-item' },
          a { href: product.link }, product.name
      )

module.exports = App
