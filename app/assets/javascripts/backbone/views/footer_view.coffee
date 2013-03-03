
class Sneakernet.Views.FooterView extends Backbone.View

  initialize: ->
    @render()

  render: ->
    data = {}
    # data.current_user = window.current_user
    @$el.html HandlebarsTemplates['shared/footer'](data)
    @