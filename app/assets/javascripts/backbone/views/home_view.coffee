
class Sneakernet.Views.HomeView extends Backbone.View

  initialize: ->
    @render()

  events:
    'click .continue':'request'

  render: ->
    @$el.html HandlebarsTemplates['home/index']({})
    @

  request: ->
    Sneakernet.router.navigate("request", {trigger:true})

