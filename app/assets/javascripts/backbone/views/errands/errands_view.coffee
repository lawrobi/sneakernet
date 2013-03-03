
class Sneakernet.Views.ErrandsView extends Backbone.View

  initialize: (options) ->
    @collection = options.collection
    @collection.on 'reset', @render, @
    @collection.on 'remove', @render, @
    @collection.on 'add', @addOne, @
    @render()

  addOne: (errand) ->
    view = new Sneakernet.Views.ErrandView(model: errand)
    ($ ".errands-list").append view.render().el

  render: ->
    @$el.html HandlebarsTemplates['errands/errands']()
    @collection.each(@addOne, @)
    @