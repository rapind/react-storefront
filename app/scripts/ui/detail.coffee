accounting = require('accounting')

{div, h1, p, a} = React.DOM

Detail = React.createClass
  mixins: [Router.State]

  getInitialState: ->
    { product: null }

  # Find and set our product from the passed products property.
  findAndSetProduct: (props) ->
    id = @getParams().id
    products = props.products
    # console.log "id", id, "products", products

    if id? && products?
      product = _.find(products, (product) ->
        product.id == parseInt(id)
      )
      @setState { product: product }

  # Fires whenever a routing change loads this component.
  componentWillReceiveProps: (nextProps) ->
    @findAndSetProduct(nextProps)

  # For some reason, the very first routing doesn't fire componentWillReceiveProps,
  # so we have to duplicate our code a bit.
  componentWillMount: ->
    @findAndSetProduct(@props)

  # We're rendering based on the component's state instead of it's props.
  render: ->
    unless @state.product?
      return ( div {}, "Select a product..." )

    { link, name, description, price } = @state.product

    div { className: "jumbotron" },
      h1 {}, name
      p {}, description
      p {},
        a { href: link, className: "btn btn-primary btn-lg", role: "button" }, "Buy Now for #{accounting.formatMoney(price)}"

module.exports = Detail
