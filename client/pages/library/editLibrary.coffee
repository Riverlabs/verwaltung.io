_.extend Template.editLibrary, 
  library: () ->
    Libraries.findOne(Meteor.router.pages().invocation().library)
  rendered: () -> $('abbr').timeago()
  events: 
    'submit form': (event) ->
      event.preventDefault()
      Libraries.update Meteor.router.pages().invocation().library, 
        $set: $('form').toObject(), 
        () ->
          Session.set 'message', type: 'success', text: 'Ihre Änderungen wurden erfolgreich gespeichert.'
