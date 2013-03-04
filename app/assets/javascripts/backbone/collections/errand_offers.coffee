class Sneakernet.Collections.ErrandOffers extends Backbone.Collection
  model: Sneakernet.Models.ErrandOffer
  url: '/api/errand_offers'

  initialize: ->
  comparator: (errand) ->
    errand.get "leaving_at"