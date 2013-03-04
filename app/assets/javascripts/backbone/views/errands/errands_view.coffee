
class Sneakernet.Views.ErrandsView extends Backbone.View

  initialize: (options) ->
    @errand = JSON.parse($.cookie("errand"))
    if not @errand
      @errand = {}
    if not @errand.source_place or @errand.source_place == null
      @errand.source_place = {}
      @errand.source_place.display_name = default_source.display_name
      @errand.source_place_id = default_source.id
    if not @errand.arrival_place or @errand.arrival_place == null
      @errand.arrival_place = {}
      @errand.arrival_place.display_name = default_destination.display_name
      @errand.arrival_place_id = default_destination.id

    if options.collection
      @collection = options.collection
    else
      @collection = new Sneakernet.Collections.Errands()
      @collection.fetch
        data:
          source_place_id:@errand.source_place_id
          arrival_place_id:@errand.arrival_place_id

    @collection.on 'reset', @render, @
    @collection.on 'remove', @render, @
    @collection.on 'add', @addOne, @

  #@render()
  events:
    'change input':'search'

  addOne: (errand) ->
    view = new Sneakernet.Views.ErrandView(model: errand)
    ($ ".errands-view").append view.render().el

  render: ->
    json = {l: @collection.models.length, from:@errand.source_place_id, to:@errand.arrival_place_id}

    @$el.html HandlebarsTemplates['errands/errands'](json)
    select_city("#deliver_to", @errand.arrival_place.display_name)
    select_city("#deliver_from", @errand.source_place.display_name)
    @collection.each(@addOne, @)
    @

  search: ->
    @errand.arrival_place_id = $("#deliver_to").val()
    @errand.arrival_place = {}
    @errand.arrival_place.display_name = $("#s2id_deliver_to .select2-choice span").text()
    @errand.source_place_id = $("#deliver_from").val()
    @errand.source_place = {}
    @errand.source_place.display_name = $("#s2id_deliver_from .select2-choice span").text()
    @collection.fetch
      data:
        source_place_id:@errand.source_place_id
        arrival_place_id:@errand.arrival_place_id
