_.extend Template.editLibrary, 
  library: () ->
    Libraries.findOne(Meteor.router.pages().invocation().library)
  events: 
    'submit form': (event) ->
      event.preventDefault()
      Libraries.update Meteor.router.pages().invocation().library, 
        $set: $('form').toObject(), 
        () ->
          woopraTracker?.pushEvent name: 'editedLibrary', id: Meteor.router.pages().invocation().library
          Session.set 'message', type: 'success', text: 'Ihre Änderungen wurden erfolgreich gespeichert.'
