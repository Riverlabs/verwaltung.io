_.extend Template.editLibraryItem, 
  library: () ->
    libraryItem = LibraryItems.findOne(Meteor.router.pages().invocation().libraryItem)
    if libraryItem
      return Libraries.findOne(libraryItem.library)
  fields: () ->
    Fields.find (library: @_id), (sort: created: 1)
  events: 
    'keyup input, change input, keyup textarea, change textarea': (event) ->
      fields = {}
      _.each $('form').toObject(skipEmpty: false), (value, key) ->
        fields["fields.#{key}"] = value
      LibraryItems.update Meteor.router.pages().invocation().libraryItem,
        $set: fields

_.extend Template.editLibraryItemField, 
  field: () ->
    libraryItem = LibraryItems.findOne(Meteor.router.pages().invocation().libraryItem)
    libraryItemValue = libraryItem?.fields?[@_id]
    # if libraryItemValue isnt undefined
    @value = libraryItemValue
    if Template["#{@type}Field"]
      Template["#{@type}Field"](@)
    else
      Template.textField(@)
