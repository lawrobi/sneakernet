
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
    errand.deadline = $(".errand_place1").val()
    $.cookie("errand", JSON.stringify(errand), 1)
    Sneakernet.router.navigate("request", {trigger:true})
