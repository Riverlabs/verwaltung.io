_.extend Template.helpHistory,
  history: () ->
    Meteor.http.get 'https://api.trello.com/1/boards/51503a5e154903b35d0082ba/cards?filter=all&key=732d5a4c68c7797aedc13a15f0f6dc2a', 
      (error, result) -> console.log result.data
