
class Sneakernet.Views.AcceptedErrand extends Backbone.View
  # tagName: "tr"
  events:
    'click .complete-request':'complete'

  complete: ->
    @model.complete()
    false

  initialize: ->
    @model.on 'change', @render, @



  render: ->
    json = @model.toJSON()
    json['pending'] = true if json.status == 'pending'
    json['completed'] = true if json.status == 'completed'
    @$el.html HandlebarsTemplates['users/accepted_errand'](json)
    @