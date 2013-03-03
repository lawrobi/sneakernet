class Sneakernet.Routers.MainsRouter extends Backbone.Router
  initialize: (options) ->
    @header = new Sneakernet.Views.HeaderView({el:"#header"})
    $("html").on "click", ".link", (event) ->
      event.preventDefault()
      if @getAttribute('data-page') == 'home'
        Sneakernet.router.navigate @getAttribute(''), {trigger:true}
      else
        Sneakernet.router.navigate @getAttribute('href'), {trigger:true}

  routes:
    '': 'main'
    'about':'about'
    'errands':'errands'
    'request':'request'
    '_=_':'main'

  main: ->
    @view = new Sneakernet.Views.HomeView({el:"#content"})
    movieFormatResult = (movie) ->
      markup = "<table class='movie-result'><tr>"
      markup += "<td class='movie-image'><img src='" + movie.posters.thumbnail + "'/></td>"  if movie.posters isnt `undefined` and movie.posters.thumbnail isnt `undefined`
      markup += "<td class='movie-info'><div class='movie-title'>" + movie.title + "</div>"
      if movie.critics_consensus isnt `undefined`
        markup += "<div class='movie-synopsis'>" + movie.critics_consensus + "</div>"
      else markup += "<div class='movie-synopsis'>" + movie.synopsis + "</div>"  if movie.synopsis isnt `undefined`
      markup += "</td></tr></table>"
      markup
    movieFormatSelection = (movie) ->
      movie.title
    placeFormatResult = (place) ->
      "#{place.display_name}"

    placeFormatSelection = (place) ->
      place.display_name

    $("#deliver_to").select2
      minimumInputLength: 1
      ajax:
        url: '/api/places'
        data: (term, page) ->
          q: term
        results: (data, page) ->
          console.log data
          {results:data}
      formatResult: placeFormatResult
      formatSelection: placeFormatSelection
      escapeMarkup: (m) ->
        m


  request: ->
    @view = new Sneakernet.Views.ErrandForms({el:"#content"})

  errands: ->
    @errands = new Sneakernet.Collections.Errands()
    @errands.fetch()
    @view = new Sneakernet.Views.ErrandsView
      el:"#content"
      collection: @errands

  about: ->
    @view = new Sneakernet.Views.StaticView({el:"#content", page:'about'})
