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


window.setCookie = (c_name, value, exdays) ->
  exdate = new Date()
  exdate.setDate exdate.getDate() + exdays
  c_value = escape(value) + ((if (not (exdays?)) then "" else "; expires=" + exdate.toUTCString()))
  document.cookie = c_name + "=" + c_value
window.getCookie = (c_name) ->
  i = undefined
  x = undefined
  y = undefined
  ARRcookies = document.cookie.split(";")
  i = 0
  while i < ARRcookies.length
    x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="))
    y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1)
    x = x.replace(/^\s+|\s+$/g, "")
    return unescape(y)  if x is c_name
    i++


$(document).on "keyup", "input.choose_place", (_.debounce ->
  unless $(@).attr("data-last-value") == @value
    if @value.length == 0
      $("#results").html("")
    else
      q = encodeURIComponent(@value)
      $(".spinner").show()
      $.get("/api/places?q="+q, (result) ->
        $("#results").html HandlebarsTemplates['places/list'](result)
        $(".spinner").hide()
      )
    $(@).attr("data-last-value", @value)
    false
)


window.select_city = (obj) ->

  placeFormatResult = (place) ->
    "#{place.display_name}"

  placeFormatSelection = (place) ->
    place.display_name

  $(obj).select2
    minimumInputLength: 1
    ajax:
      url: '/api/places'
      data: (term, page) ->
        q: term
      results: (data, page) ->
        {results:data}
    formatResult: placeFormatResult
    formatSelection: placeFormatSelection
    escapeMarkup: (m) ->
      m
