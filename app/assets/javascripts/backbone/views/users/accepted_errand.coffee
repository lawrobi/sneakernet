
class Sneakernet.Views.AcceptedErrand extends Backbone.View
  # tagName: "tr"
  events:
    'click .get':'get'
  get: ->

  initialize: ->
    @model.on 'change', @render, @

  render: ->
    @$el.html HandlebarsTemplates['users/accepted_errand'](@model.toJSON())
    @