_.extend Template.library,
  library: ->
    Libraries.findOne(Meteor.router.pages().invocation().library)
