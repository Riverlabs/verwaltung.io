HelpHistory = new Meteor.Collection 'helpHistory'
Meteor.autorun ->
  window.helpHistoryHandler = Meteor.subscribe "helpHistory"

_.extend Template.helpHistory,
  lists: () ->
    HelpHistory.find
      idList: 
        $exists: false 
      name: /Version */i
  cards: () ->
    HelpHistory.find(idList: @_id)
