Meteor.autorun ->
  window.librariesHandler = Meteor.subscribe "libraries"

_.extend Template.navigation,
  libraries: ->
    Libraries.find()
  activeClass: ->
    'active' if @_id is Meteor.router.pages().invocation().library
