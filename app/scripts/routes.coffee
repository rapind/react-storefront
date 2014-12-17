Route = Router.Route

App = require('./ui/app.coffee')
Detail = require('./ui/detail.coffee')

routes = (
  Route { handler: App, path: "/" },
    Route { name: "product", path: ":id", handler: Detail }
)

Router.run(routes, (Handler) ->
  React.render (Handler {}), document.getElementById('app')
)
