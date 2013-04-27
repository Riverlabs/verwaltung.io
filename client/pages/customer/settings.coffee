_.extend Template.customerSettings,
  customer: () ->
    Customers.findOne()
  events:
    'keyup input, change input': () ->
      if customerId = Customers.findOne()?._id
        Customers.update customerId, 
          $set: $('form').toObject(skipEmpty: false, emptyToNull: false)
