class Sneakernet.Models.ErrandOffer extends Backbone.Model
  paramRoot: 'errand_offer'


  accept: ->
    #@url: ->
    #  "/api/errand_offers/#{@id}"
    @set 'status', 'accepted'
    @save
