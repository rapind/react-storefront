{div, h1, p, a} = React.DOM

Detail = React.createClass
  mixins: [Router.State]

  getInitialState: ->
    { product: null }

  loadData: ->
    id = @getParams().id
    return unless id

    console.log 'load data for detail'
    $.ajax(
      url: "/data/#{id}.json"
      dataType: 'json'
      success: (data) =>
        console.log "detail data:", data
        @setState { product: data }
      error: () ->
        console.log 'Error loading data'
    )

  componentWillMount: ->
    @loadData()

  componentWillReceiveProps: ->
    @loadData()

  render: ->
    unless @state.product?
      return ( div {}, "Select a product..." )

    { link, name, description, price, categories } = @state.product

    div { className: "jumbotron" },
      h1 {}, name
      p {}, description
      p {},
        a { href: link, className: "btn btn-primary btn-lg", role: "button" }, "Buy Now for $#{price}"

module.exports = Detail
