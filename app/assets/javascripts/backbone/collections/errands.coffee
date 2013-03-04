class Sneakernet.Collections.Errands extends Backbone.Collection
  model: Sneakernet.Models.Errand
  url: '/api/errands'

  initialize: ->
  comparator: (errand) ->
    errand.get "deadline"