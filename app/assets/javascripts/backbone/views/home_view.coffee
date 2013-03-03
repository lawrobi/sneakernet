
class Sneakernet.Views.HomeView extends Backbone.View

  initialize: ->
    @errand_form = $("form[name='errand_new']")
    @render()

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
    #errand.place1 = $(".errand_place1").val()
    errand.deliver_to_id = $("#deliver_to").val()
    errand.deliver_to_name = $("#id_s2deliver_to .select2-choice span").text()
    $.cookie("errand", JSON.stringify(errand), 1)
    Sneakernet.router.navigate("request", {trigger:true})
