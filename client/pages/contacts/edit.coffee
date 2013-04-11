_.extend Template.editContact,
  events:
    'keyup input, change input, keyup textarea, change textarea, change select': () ->
      Meteor.users.update @_id, $set: flattenObject $('form').toObject(skipEmpty: false, emptyToNull: false)
