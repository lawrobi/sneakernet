class Snickernet.Models.Errand extends Backbone.Model
  paramRoot: 'errand'

  defaults:

class Snickernet.Collections.ErrandsCollection extends Backbone.Collection
  model: Snickernet.Models.Errand
  url: '/errands'
