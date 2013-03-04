
class Sneakernet.Views.RequestedErrand extends Backbone.View
  tagName: "tr"
  events:
    'click .get':'get'
  get: ->

  initialize: ->
    @model.on 'change', @render, @

  render: ->
    @$el.html HandlebarsTemplates['users/requested_errand'](@model.toJSON())
    @