class Sneakernet.Views.SingleErrand extends Backbone.View

  initialize: ->
    @model = new Sneakernet.Models.Errand {id:@options.errand_id}
    @model.on 'change', @render, @
    @model.fetch()

  render: ->
    @$el.html HandlebarsTemplates['errands/single_errand'](@model.toJSON())
    @