#= require_self
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

window.Sneakernet =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  init: ->
    @router = new Sneakernet.Routers.MainsRouter()
    Backbone.history.start({pushState: true})

$ ->
  Sneakernet.init()