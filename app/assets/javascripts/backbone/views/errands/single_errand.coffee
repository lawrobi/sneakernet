class Sneakernet.Views.SingleErrand extends Backbone.View

  initialize: ->
    @model = new Sneakernet.Models.Errand {id:@options.errand_id}
    @model.on 'change', @render, @
    @model.fetch()

  events:
    'click .accept':'accept'

  render: ->
    @$el.html HandlebarsTemplates['errands/single_errand'](@model.toJSON())
    @

  accept: ->
    if window.current_user
      @collection = new Sneakernet.Collections.ErrandOffers()
      bid = @model.get('estimated_price') - 30 + Math.random(60)
      errand_id=@model.get('id')
      @collection.create
        errand_id:errand_id
        bid:bid
        leaving_at:today
        arriving_at:tomorrow
    else
      $('.login-link').trigger 'click'
      false



