class Sneakernet.Views.Profile extends Backbone.View

  initialize: ->
    @model = new Sneakernet.Models.User {id:@options.user_id}
    #@model.on 'change', @renderProfileHead, @
    #@model.on 'change', @renderUserStats, @
    @model.on 'change', @render, @
    @model.fetch()

  events:
    'click .get':'get'

  render: ->
    @$el.html HandlebarsTemplates['users/profile'](@model.toJSON())
    @