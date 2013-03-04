
class Sneakernet.Views.Dashboard extends Backbone.View

  initialize: (options) ->
    @requested_errands = new Sneakernet.Collections.Errands()
    @requested_errands.fetch()
    @render()
    @view = new Sneakernet.Views.RequestedErrands
      el:"#requested_errands"
      collection: @requested_errands


  render: ->
    @$el.html HandlebarsTemplates['users/dashboard']()
    @