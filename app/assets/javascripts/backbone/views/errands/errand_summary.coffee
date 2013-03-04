class Sneakernet.Views.ErrandSummary extends Backbone.View
  initialize: ->
    @errand = JSON.parse($.cookie("errand_ready"))
    if not @errand
      Sneakernet.router.navigate("", {trigger:true})
    if not window.current_user
      Sneakernet.router.navigate("", {trigger:true})
    @render()

    #select_city("#deliver_to", @errand.arrival_place.display_name)

  events:
    'click .submit': 'submit'

  submit: ->
    $('.show-success').trigger 'click'
    collection = new Sneakernet.Collections.Errands()
    collection.create(@errand)

  render: ->
    @$el.html HandlebarsTemplates['errands/summary']({errand:@errand})
    @

