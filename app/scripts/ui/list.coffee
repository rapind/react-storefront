{ol, li, a} = React.DOM

List = React.createClass
  getInitialState: ->
    { categories: [], products: [] }

  loadData: ->
    console.log 'load data for list'
    $.ajax(
      url: '/data/list.json'
      dataType: 'json'
      success: (data) =>
        console.log "list data:", data
        @setState { categories: data.categories, products: data.products }
      error: () ->
        console.log 'Error loading data'
    )

  componentWillMount: ->
    @loadData()

  render: ->
    ol { className: 'list-group' },
      @state.products.map (product) ->
        ListItem { key: product.id, id: product.id, name: product.name }

ListItem = React.createClass
  propTypes:
    id: React.PropTypes.number.isRequired
    name: React.PropTypes.string.isRequired

  render: ->
    { id, name } = @props

    li { className: 'list-group-item' },
      Router.Link { to: "/#{id}" }, name

module.exports = List
