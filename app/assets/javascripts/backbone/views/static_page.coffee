
class Sneakernet.Views.StaticView extends Backbone.View

  initialize: (options) ->
    @page = options.page
    @render()

  render: ->
    @$el.html HandlebarsTemplates["home/#{@page}"]({})
    @