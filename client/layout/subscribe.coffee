Meteor.autorun () ->
  Meteor.subscribe 'userData'
  Meteor.subscribe 'allUserData'
  Meteor.subscribe 'customers', window.location.host
