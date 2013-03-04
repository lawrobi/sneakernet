Handlebars.registerHelper "sitename", () ->
  "Bring My Stuff"

Handlebars.registerHelper "today", () ->
  window.today()

Handlebars.registerHelper "tomorrow", () ->
  window.tomorrow()

Handlebars.registerHelper "default_destination_name", () ->
  window.default_destination.display_name

Handlebars.registerHelper "default_source_name", () ->
  window.default_source.display_name

Handlebars.registerHelper "default_destination_id", () ->
  window.default_destination.id

Handlebars.registerHelper "default_source_id", () ->
  window.default_source.id

Handlebars.registerHelper "format_date", (date) ->
  if date
    moment(date).format('LL')
  else
    "No date"

Handlebars.registerHelper "link_to", (type, obj) ->
  "/#{type}/#{obj.id}"


