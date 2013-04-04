_.extend Template.message, 
  message: () ->
    Meteor.clearTimeout(window.messageTimer)
    window.messageTimer = Meteor.setTimeout () ->
      Session.set 'message', undefined
    , 3000
    Session.get 'message'
