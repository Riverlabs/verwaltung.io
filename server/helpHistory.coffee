HelpHistoryCards = {}
HelpHistoryLists = {}

fetchTrello = () ->
  Meteor.http.get 'https://api.trello.com/1/boards/51503a5e154903b35d0082ba/cards?key=732d5a4c68c7797aedc13a15f0f6dc2a', 
    (error, result) ->
      HelpHistoryCards = {}
      _.each result?.data, (card) ->
        HelpHistoryCards[card.id] = card

  Meteor.http.get 'https://api.trello.com/1/boards/51503a5e154903b35d0082ba/lists?filter=all&key=732d5a4c68c7797aedc13a15f0f6dc2a', 
    (error, result) -> 
      HelpHistoryLists = {}
      _.each result?.data, (list) ->
        HelpHistoryLists[list.id] = list

Meteor.setInterval fetchTrello, 1000*10
fetchTrello()

Meteor.publish 'helpHistory', ->
  _helpHistory = {}
  _interval= Meteor.setInterval () =>
    HelpHistory = _.extend HelpHistoryCards, HelpHistoryLists
    _.each HelpHistory, (item) =>
      if _helpHistory[item.id] and not _.isEqual _helpHistory[item.id], item
        _helpHistory[item.id] = item
        @changed 'helpHistory', item.id, item
      else if not _helpHistory[item.id]
        _helpHistory[item.id] = item
        @added 'helpHistory', item.id, item
    _.each _helpHistory, (item) =>
      unless HelpHistory[item.id]
        @removed 'helpHistory', item.id
        delete _helpHistory[item.id]

  , 1000
  @onStop () -> 
    Meteor.clearInterval _interval