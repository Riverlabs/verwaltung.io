_.extend Template.editLibraryItem, 
  library: () ->
    libraryItem = LibraryItems.findOne(Meteor.router.pages().invocation().libraryItem)
    if libraryItem
      return Libraries.findOne(libraryItem.library)
  fields: () ->
    Fields.find (library: @_id), (sort: created: 1)
  events: 
    'submit form': (event) ->
      event.preventDefault()
      console.log $('form').toObject()
      LibraryItems.update Meteor.router.pages().invocation().libraryItem,
        $set: fields: $('form').toObject()
      , () ->
        Session.set 'message', type: 'success', text: 'Ihr Eintrag wurde erfolgreich bearbeitet.'
        Meteor.go Meteor.libraryPath(_id: LibraryItems.findOne(Meteor.router.pages().invocation().libraryItem).library)

_.extend Template.editLibraryItemField, 
  field: () ->
    @default = LibraryItems.findOne(Meteor.router.pages().invocation().libraryItem)?.fields[@_id]
    if Template["#{@type}Field"]
      Template["#{@type}Field"](@)
    else
      Template.textFieldEdit(@)
