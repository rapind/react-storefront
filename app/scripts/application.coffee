$ = window.$ = require('../../bower_components/jquery/dist/jquery.js')
_ = window._ = require('../../bower_components/lodash/dist/lodash.js')
React = window.React = require('react')
App = window.App = require('./ui/app.coffee')

$ ->
  React.renderComponent(
    App({ dataUrl: '/data/app.json' })
    document.getElementById('app')
  )
