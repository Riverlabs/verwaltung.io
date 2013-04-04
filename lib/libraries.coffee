Libraries = new Meteor.Collection 'libraries'
Libraries.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true

LibraryItems = new Meteor.Collection 'libraryitems'
LibraryItems.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true


Fields = new Meteor.Collection 'fields'
Fields.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true


if Meteor.isServer
  Meteor.publish 'libraries', () ->
    Libraries.find()
  Meteor.publish 'libraryitems', () ->
    LibraryItems.find()
  Meteor.publish 'fields', () ->
    Fields.find()
