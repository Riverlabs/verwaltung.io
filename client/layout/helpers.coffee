Handlebars.registerHelper 'message', () ->
  Session.get 'message'
