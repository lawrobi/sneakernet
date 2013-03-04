class Sneakernet.Models.Errand extends Backbone.Model
  paramRoot: 'errand'

  url:-> "/api/errands/#{@id}"

