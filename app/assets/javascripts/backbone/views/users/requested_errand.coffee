
class Sneakernet.Views.RequestedErrand extends Backbone.View
  # tagName: "tr"
  events:
    'click .accept':'accept'

  accept: ->
    #@model.accept()
    false

  initialize: ->
    @model.on 'change', @render, @

  render: ->
    @$el.html HandlebarsTemplates['users/requested_errand'](@model.toJSON())
    @