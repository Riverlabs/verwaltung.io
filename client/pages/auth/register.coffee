_.extend Template.register,
  events:
    'submit form': (event) ->
      event.preventDefault()
      Accounts.createUser (email: $('#email').val(), password: $('#password').val(), profile: name: $('#name').val()), (error)->
        if error
          Session.set 'error', error.reason 
        else
          Meteor.go('/')
