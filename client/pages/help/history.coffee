HelpHistory = new Meteor.Collection 'helpHistory'
Meteor.autorun ->
  window.helpHistoryHandler = Meteor.subscribe "helpHistory"

_.extend Template.helpHistory,
  rendered: () -> $('abbr').timeago()
  nameWithoutDate: () ->
    @name.replace /\((.*)\)/, ''
  date: () ->
    match = /\((.*)\)/.exec @name
    match?[1]
  members: () ->
    if @idMembers
      HelpHistory.find(_id: $in: @idMembers)
  lists: () ->
    HelpHistory.find
      idList: 
        $exists: false 
      name: /Version */i
    , sort: name: -1
  cards: () ->
    HelpHistory.find
      idList: @_id
    , sort: pos: 1
  # attachmentPreview: () ->
  #   preview = _.where @previews, height: 320
  #   console.log preview[0].url
