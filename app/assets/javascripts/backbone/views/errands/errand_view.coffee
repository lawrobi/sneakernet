
class Sneakernet.Views.ErrandView extends Backbone.View
  tagName: "tr"
  events:
    'click .get':'get'
  get: ->

  initialize: ->
    @model.on 'change', @render, @

  render: ->
    @$el.html HandlebarsTemplates['errands/errand'](@model.toJSON())
    @