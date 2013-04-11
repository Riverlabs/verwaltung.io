Libraries = new Meteor.Collection 'libraries'
Libraries.allow
  insert: (userId, doc) ->
    doc.createdBy = userId
    doc.createdAt = new Date()
    true
  update: (userId, doc, fieldNames, modifier) ->
    modifier.$set.updatedBy = userId
    modifier.$set.updatedAt = new Date()
    doc.createdBy is userId
  remove: (userId, doc) ->
    doc.createdBy is userId

LibraryItems = new Meteor.Collection 'libraryitems'
LibraryItems.allow
  insert: (userId, doc) ->
    doc.createdBy = userId
    doc.createdAt = new Date()
    true
  update: (userId, doc, fieldNames, modifier) ->
    modifier.$set.updatedBy = userId
    modifier.$set.updatedAt = new Date()
    true
  remove: (userId, doc) ->
    true


Fields = new Meteor.Collection 'fields'
Fields.allow
  insert: (userId, doc) ->
    doc.createdBy = userId
    doc.createdAt = new Date()
    true
  update: (userId, doc, fieldNames, modifier) ->
    modifier.$set.updatedBy = userId
    modifier.$set.updatedAt = new Date()
    true
  remove: (userId, doc) ->
    true


if Meteor.isServer
  Meteor.publish 'libraries', () ->
    Libraries.find(createdBy: @userId)
  Meteor.publish 'libraryitems', () ->
    # TODO: Only publish items for current user
    LibraryItems.find()
  Meteor.publish 'fields', () ->
    # TODO: Only publish fields for current user
    Fields.find()
  Meteor.publish 'userData', () ->
    Meteor.users.find(_id: @userId, {fields: admin: 1})
  Meteor.publish 'allUserData', () ->
    # TODO: Auf Benutzer einschränken mit denenen der angemeldete Benutzer in Kontakt ist.
    Meteor.users.find({}, {fields: profile: 1})
    console.log @
