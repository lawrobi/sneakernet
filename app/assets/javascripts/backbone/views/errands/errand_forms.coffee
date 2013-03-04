class Sneakernet.Views.ErrandForms extends Backbone.View

  events:
    'click .next_form':'next_form'
    'click .submit_form':'submit_form'

  get: ->

  initialize: ->
    @errand = JSON.parse($.cookie("errand"))
    if not @errand
      Sneakernet.router.navigate("", {trigger:true})


    @current_form = 1

    @render()
    select_city("#deliver_to", @errand.arrival_place.display_name)
    @switch_form()



  next_form: ->
    @current_form = @current_form + 1
    @switch_form()

  submit_form: ->
    fields = $("#request_form").find("input")
    errand = {}
    $.each fields, (n, f) ->
      field_name = $(f).attr('data-field')
      errand[field_name] = $(f).val() if field_name
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


  render: ->
    @$el.html HandlebarsTemplates['errands/forms']({errand:@errand})
    @

  switch_form: ->
    $(".forms").hide()
    $(".forms[data-index='#{@current_form}']").show()