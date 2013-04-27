_.extend Template.customerTeam,
  customer: () ->
    Customers.findOne()
  users: () ->
    if @users
      Meteor.users.find _id: $in: @users
