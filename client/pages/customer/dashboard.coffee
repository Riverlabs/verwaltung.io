_.extend Template.customerDashboard,
  customer: () ->
    Customers.findOne()
  users: () ->
    if @users
      Meteor.users.find _id: $in: @users
