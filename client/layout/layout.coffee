_.extend Template.layout,
  rendered: () ->
    $('abbr').timeago()
    woopraTracker?.trackPageview
      url: Meteor.router.path()

_.extend Template.framelessLayout,
  rendered: () ->
    $('abbr').timeago()
    woopraTracker?.trackPageview
      url: Meteor.router.path()
