Libraries = new Meteor.Collection 'libraries'
Libraries.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    true

if Meteor.isServer
  Meteor.publish 'libraries', () ->
    Libraries.find()
