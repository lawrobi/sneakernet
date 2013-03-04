Handlebars.registerHelper "sitename", () ->
  "Bring My Stuff"

Handlebars.registerHelper "today", () ->
  window.today()

Handlebars.registerHelper "tomorrow", () ->
  window.tomorrow()

Handlebars.registerHelper "default_destination", () ->
  window.default_destination