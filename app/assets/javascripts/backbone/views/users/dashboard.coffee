
class Sneakernet.Views.Dashboard extends Backbone.View

  initialize: (options) ->
    @requested_errands = new Sneakernet.Collections.Errands()
    @requested_errands.url = "/api/users/#{current_user.id}/requested_errands"
    @requested_errands.fetch()
    @accepted_errands = new Sneakernet.Collections.Errands()
    @accepted_errands.url = "/api/users/#{current_user.id}/accepted_errands"
    @accepted_errands.fetch()
    @render()
    @requested_errands_view = new Sneakernet.Views.RequestedErrands
      el:"#requested_errands"
      collection: @requested_errands
    @accepted_errands_view = new Sneakernet.Views.AcceptedErrands
      el:"#accepted_errands"
      collection: @accepted_errands


  render: ->
    @$el.html HandlebarsTemplates['users/dashboard']()
    @