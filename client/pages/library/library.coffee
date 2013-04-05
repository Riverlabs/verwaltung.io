Meteor.autorun ->
  window.librariesHandler = Meteor.subscribe "libraries"
  window.librariesHandler = Meteor.subscribe "libraryitems"
  window.fieldsHandler = Meteor.subscribe "fields"

_.extend Template.library,
  library: () ->
    Libraries.findOne(Meteor.router.pages().invocation().library)
  items: () ->
    LibraryItems.find (library: @_id), (sort: created: -1)
  fields: () ->
    Fields.find (library: @_id), (sort: created: 1)

_.extend Template.libraryTableItem,
  values: () ->
    fields = Fields.find((library: @library), (sort: created: 1)).fetch()
    _.map fields, (value, key) => return _.extend value, (value: @fields[value._id])
  field: () ->
    if Template["#{@type}FieldTable"]
      Template["#{@type}FieldTable"](@)
    else
      Template.textFieldTable(@)
