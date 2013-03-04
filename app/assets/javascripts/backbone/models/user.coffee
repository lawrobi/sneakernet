class Sneakernet.Models.User extends Backbone.Model
  initialize: ->
    errands_json = (@get 'errands') || []
    @errands = new Sneakernet.Collections.Errands(errands_json)
    @errands.url = "/api/users/#{@id}/errands"

  url:-> "/api/users/#{@id}"

