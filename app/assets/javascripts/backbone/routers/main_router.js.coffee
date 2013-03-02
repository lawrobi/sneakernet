class Sneakernet.Routers.MainsRouter extends Backbone.Router
  initialize: (options) ->
    $("html").on "click", ".link", (event) ->
      event.preventDefault()
      if @getAttribute('data-page') == 'home'
        Sneakernet.router.navigate @getAttribute(''), {trigger:true}
      else
        Sneakernet.router.navigate @getAttribute('href'), {trigger:true}

  routes:
    '': 'main'
    'about':'about'

  main: ->
    @view = new Sneakernet.Views.HomeView({el:"#content"})

  about: ->
    @view = new Sneakernet.Views.StaticView({el:"#content", page:'about'})
