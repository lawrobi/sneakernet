
class Sneakernet.Views.RequestedErrands extends Backbone.View

  initialize: (options) ->
    @collection = options.collection
    @collection.on 'reset', @render, @
    @collection.on 'remove', @render, @
    @collection.on 'add', @addOne, @
  #@render()

  addOne: (errand) ->
    view = new Sneakernet.Views.RequestedErrand(model: errand)
    ($ ".errands-view").append view.render().el

  render: ->
    json = {l: @collection.models.length}
    @$el.html HandlebarsTemplates['users/requested_errands'](json)
    @collection.each(@addOne, @)
    @