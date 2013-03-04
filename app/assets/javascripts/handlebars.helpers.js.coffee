Handlebars.registerHelper "sitename", () ->
  "Bring My Stuff"

Handlebars.registerHelper "today", () ->
  window.today()

Handlebars.registerHelper "tomorrow", () ->
  window.tomorrow()