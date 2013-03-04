
class Sneakernet.Views.HomeView extends Backbone.View

  initialize: ->
    @errand_form = $("form[name='errand_new']")
    @render()
    @errand = JSON.parse($.cookie("errand_ready"))
    #if @errand
    #go to create create

    $('input#errand_deadline').pikaday({format: 'M/D/YYYY'})
    #temprory deletes cookie when launched
    setCookie("errand", null, 1)

  events:
    'click .continue': 'request'

  render: ->
    @$el.html HandlebarsTemplates['home/index']({})
    @

  request: (e) ->
    e.preventDefault()
    errand = {}
    errand.deadline = $("#errand_deadline").val()
    errand.arrival_place_id = $("#deliver_to").val()
    errand.arrival_place = {}
    errand.arrival_place.display_name = $("#s2id_deliver_to .select2-choice span").text()
    errand.source_place_id = $("#deliver_from").val()
    errand.source_place = {}
    errand.source_place.display_name = $("#s2id_deliver_from .select2-choice span").text()
    if not errand.deadline
      errand.deadline = tomorrow()

    $.cookie("errand", JSON.stringify(errand), 1)
    Sneakernet.router.navigate("request", {trigger:true})
