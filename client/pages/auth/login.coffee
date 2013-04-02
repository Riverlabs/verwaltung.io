_.extend Template.login, 
  events:
    'submit form': (event) ->
      event.preventDefault()
      Session.set 'message', undefined
      Meteor.loginWithPassword $('#email').val(), $('#password').val(), (error)->
        if error
          Session.set 'message', type: 'error', text: error.reason
        else
          Meteor.go('/')
