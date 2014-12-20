{ol, li, a} = React.DOM

List = React.createClass
  render: ->
    ol { className: 'list-group' },
      @props.products.map (product) ->
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
