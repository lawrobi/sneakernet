class Sneakernet.Routers.MainsRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    '': 'main'

  main: ->
    @view = new Sneakernet.Views.HomeView({el:"#content"})