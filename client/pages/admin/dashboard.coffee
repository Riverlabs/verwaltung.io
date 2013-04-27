_.extend Template.adminDashboard,
  users: () ->
    Meteor.users.find()
  libraries: () ->
    Libraries.find()
  libraryItems: () ->
    LibraryItems.find()
