_.extend Template.createLibraryItem, 
  library: () ->
    Libraries.findOne(Meteor.router.pages().invocation().library)
  fields: () ->
    Fields.find (library: @_id), (sort: created: 1)
  events: 
    'submit form': (event) ->
      event.preventDefault()
      console.log $('form').toObject()
      LibraryItems.insert
        library: Meteor.router.pages().invocation().library
        created: new Date()
        fields: $('form').toObject()
      , () ->
        Session.set 'message', type: 'success', text: 'Ihr Eintrag wurde erfolgreich hinzugefügt.'
        Meteor.go Meteor.libraryPath(_id: Meteor.router.pages().invocation().library)

_.extend Template.createLibraryItemField, 
  field: () ->
    if Template["#{@type}Field"]
      Template["#{@type}Field"](@)
    else
      Template.textFieldEdit(@)
