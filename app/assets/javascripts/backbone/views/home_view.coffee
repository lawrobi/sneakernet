
class Sneakernet.Views.HomeView extends Backbone.View

  initialize: ->
    @render()

  render: ->
    @$el.html HandlebarsTemplates['home/index']({})
    @