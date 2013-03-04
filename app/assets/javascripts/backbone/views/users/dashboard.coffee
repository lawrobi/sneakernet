
class Sneakernet.Views.Dashboard extends Backbone.View

  initialize: (options) ->
    @requested_errands = new Sneakernet.Collections.Errands()
    @requested_errands.url = "/api/users/#{current_user.id}/requested_errands"
    @requested_errands.fetch()
    @accepted_errands = new Sneakernet.Collections.Errands()
    @accepted_errands.url = "/api/users/#{current_user.id}/accepted_errands"
    @accepted_errands.fetch()
    @render()
    @current_tab = 'requested_errands'
    @showTab()
    @requested_errands_view = new Sneakernet.Views.RequestedErrands
      el:"#requested_errands"
      collection: @requested_errands
    @requested_errands.on 'reset', @showTab, @
    @accepted_errands.on 'reset', @showTab, @

    @accepted_errands_view = new Sneakernet.Views.AcceptedErrands
      el:"#accepted_errands"
      collection: @accepted_errands

  events: ->
    'click .tab-pill':'switchTab'

  render: ->
    @$el.html HandlebarsTemplates['users/dashboard']()
    @

  switchTab: (e) ->
    e.preventDefault()
    tab = $(e.target).attr('data-tab')
    @current_tab = tab
    $(".dashboard-errands").hide('fast')
    $(".tab-pill").removeClass('selected')
    $(e.target).addClass('selected')
    @showTab()

  showTab: ->
    $("##{@current_tab}").fadeIn('fast')
