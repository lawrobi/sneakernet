
class Sneakernet.Views.HomeView extends Backbone.View

  initialize: ->
    @errand_form = $("form[name='errand_new']")
    @render()
    @errand = JSON.parse($.cookie("errand_ready"))
    #if @errand
    #go to create create

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
    errand.arrival_place = {}
    errand.deadline = $("#errand_deadline").val()
    errand.arrival_place_id = $("#deliver_to").val()
    errand.arrival_place.display_name = $("#s2id_deliver_to .select2-choice span").text()
    $.cookie("errand", JSON.stringify(errand), 1)
    Sneakernet.router.navigate("request", {trigger:true})
