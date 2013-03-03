
class Sneakernet.Views.ErrandView extends Backbone.View

  events:
    'click .get':'get'
  get: ->

  initialize: ->
    @model.on 'change', @render, @

  render: ->
    @$el.html HandlebarsTemplates['errands/errand'](@model.toJSON())
    @