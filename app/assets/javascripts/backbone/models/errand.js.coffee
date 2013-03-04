class Sneakernet.Models.Errand extends Backbone.Model
  paramRoot: 'errand'



  complete: ->
    #@url: ->
    #  "/api/errand_offers/#{@id}"
    @set 'status', 'completed'
    @save
