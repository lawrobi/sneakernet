class Sneakernet.Views.ErrandForms extends Backbone.View

  events:
    'click .next_form':'next_form'
    'click .submit_form':'submit_form'

  get: ->

  initialize: ->
    @errand = JSON.parse($.cookie("errand"))
    if not @errand
      @errand = {}
    #  Sneakernet.router.navigate("", {trigger:true})


    @current_form = 1

    if not @errand.source_place or @errand.source_place == null
      @errand.source_place = {}
      @errand.source_place.display_name = default_source.display_name
      @errand.source_place_id = default_source.id
    if not @errand.arrival_place or @errand.arrival_place == null
      @errand.arrival_place = {}
      @errand.arrival_place.display_name = default_destination.display_name
      @errand.arrival_place_id = default_destination.id
    if not @errand.deadline or @errand.deadline == null
      @errand.deadline = tomorrow()


    @render()
    $("input[data-field='deadline']").pikaday({format: 'M/D/YYYY'})
    $("#date-slider").slider
      value: 21
      min: 0
      max: 42
      step: 1
      slide: (event, ui) ->
        $("#amount").text "$" + (50 + ui.value * 5) + '.00'
        $('#selected-date').text moment().add('days', ui.value).format('MMMM D, YYYY');

    select_city("#deliver_to", @errand.arrival_place.display_name)
    select_city("#deliver_from", @errand.source_place.display_name)
    @switch_form()



  next_form: ->
    @current_form = @current_form + 1
    @switch_form()
    false

  submit_form: ->
    fields = $("#request_form").find("input")
    errand = {}
    errand.estimated_price = parseInt($("#amount").text().replace(/\D+/, ''))
    $.each fields, (n, f) ->
      field_name = $(f).attr('data-field')
      errand[field_name] = $(f).val() if field_name
    errand.arrival_place = {}
    errand.source_place = {}
    errand.arrival_place.display_name = $("#s2id_deliver_to .select2-choice span").text()
    errand.source_place.display_name = $("#s2id_deliver_from .select2-choice span").text()

    # if current user
    if window.current_user
      $.cookie("errand_ready", JSON.stringify(errand), 1)
      Sneakernet.router.navigate("summary", {trigger:true})
      #collection = new Sneakernet.Collections.Errands()
      #collection.create(errand)
    else
      # if not
      $.cookie("errand_ready", JSON.stringify(errand), 1)
      $('a.login-link').trigger('click')
    false

  render: ->
    @$el.html HandlebarsTemplates['errands/forms']({errand:@errand})
    @

  switch_form: ->
    $(".forms").hide()
    $(".forms[data-index='#{@current_form}']").show()
