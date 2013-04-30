@Customers = new Meteor.Collection 'customers'
Customers.allow
  insert: (userId, doc) ->
    doc.owner = userId
    doc.users = [userId]
    doc.createdAt = new Date()
    true
  update: (userId, doc, fieldNames, modifier) ->
    modifier.$set?.updatedBy = userId
    modifier.$set?.updatedAt = new Date()
    (doc.owner is userId) or (Meteor.users.findOne(userId)?.admin)
  remove: (userId, doc) ->
    (doc.owner is userId) or (Meteor.users.findOne(userId)?.admin)

@Libraries = new Meteor.Collection 'libraries'
Libraries.allow
  insert: (userId, doc) ->
    doc.createdBy = userId
    doc.createdAt = new Date()
    true
  update: (userId, doc, fieldNames, modifier) ->
    modifier.$set?.updatedBy = userId
    modifier.$set?.updatedAt = new Date()
    (doc.createdBy is userId) or (Meteor.users.findOne(userId)?.admin)
  remove: (userId, doc) ->
    (doc.createdBy is userId) or (Meteor.users.findOne(userId)?.admin)

@LibraryItems = new Meteor.Collection 'libraryitems'
LibraryItems.allow
  insert: (userId, doc) ->
    doc.createdBy = userId
    doc.createdAt = new Date()
    true
  update: (userId, doc, fieldNames, modifier) ->
    modifier.$set?.updatedBy = userId
    modifier.$set?.updatedAt = new Date()
    true
  remove: (userId, doc) ->
    true


@Fields = new Meteor.Collection 'fields'
Fields.allow
  insert: (userId, doc) ->
    doc.createdBy = userId
    doc.createdAt = new Date()
    true
  update: (userId, doc, fieldNames, modifier) ->
    modifier.$set?.updatedBy = userId
    modifier.$set?.updatedAt = new Date()
    true
  remove: (userId, doc) ->
    true


if Meteor.isServer
  Meteor.publish 'customers', (url) ->
    if url.split('.')[1] isnt 'verwaltung'
      return Customers.find('domains.custom': url)
    else
      return Customers.find('domains.subdomain': url.split('.')[0])
    # # TODO: Only publish fields for current user
    # Customers.find()
  Meteor.publish 'libraries', () ->
    if @userId
      if Meteor.users.findOne(@userId)?.admin
        return Libraries.find()
      else
        return Libraries.find(createdBy: @userId)
  Meteor.publish 'libraryitems', () ->
    if Meteor.users.findOne(@userId)?.admin
      return LibraryItems.find()
    else
      # TODO: Only publish items for current user
      LibraryItems.find()
  Meteor.publish 'fields', () ->
    # TODO: Only publish fields for current user
    Fields.find()
  Meteor.publish 'userData', () ->
    Meteor.users.find(_id: @userId, {fields: admin: 1, createdAt: 1})
  Meteor.publish 'allUserData', () ->
    # TODO: Auf Benutzer einschränken mit denenen der angemeldete Benutzer in Kontakt ist.
    if Meteor.users.findOne(@userId)?.admin
      return Meteor.users.find()
    else
      Meteor.users.find({}, {fields: profile: 1})
