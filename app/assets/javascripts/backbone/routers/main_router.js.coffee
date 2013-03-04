class Sneakernet.Routers.MainsRouter extends Backbone.Router
  initialize: (options) ->
    @header = new Sneakernet.Views.HeaderView({el:"#header"})
    @footer = new Sneakernet.Views.FooterView({el:"#footer"})
    $("html").on "click", ".link", (event) ->
      event.preventDefault()
      if @getAttribute('data-page') == 'home'
        Sneakernet.router.navigate @getAttribute(''), {trigger:true}
      else
        Sneakernet.router.navigate @getAttribute('href'), {trigger:true}

  routes:
    '': 'main'
    'about':'about'
    'static/:page':'static'
    'summary':'summary'
    'errands':'errands'
    'request':'request'
    '_=_':'main'

  main: ->
    @view = new Sneakernet.Views.HomeView({el:"#content"})
    select_city("#deliver_to")
    select_city("#deliver_from", default_destination.display_name)


  request: ->
    @view = new Sneakernet.Views.ErrandForms({el:"#content"})

  summary: ->
    @view = new Sneakernet.Views.ErrandSummary({el:"#content"})

  errands: ->
    @errands = new Sneakernet.Collections.Errands()
    @errands.fetch()
    @view = new Sneakernet.Views.ErrandsView
      el:"#content"
      collection: @errands

  about: ->
    @view = new Sneakernet.Views.StaticView({el:"#content", page:'about'})

  static: (page) ->
    @view = new Sneakernet.Views.StaticView({el:"#content", page:page})
