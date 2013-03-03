
class Sneakernet.Views.HeaderView extends Backbone.View

  initialize: ->
    @render()

  render: ->
    data = {}
    data.current_user = window.current_user
    @$el.html HandlebarsTemplates['shared/header'](data)
    @