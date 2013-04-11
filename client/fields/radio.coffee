_.extend Template.radioFieldEdit, 
  events:
    'click .addOption': (event) ->
      event.preventDefault()
      if title = prompt 'Titel der Auswahlmöglichkeit: '
        Fields.update @_id, $addToSet: options: _id: Random.id(), title: title
    'dblclick label': (event) ->
      if title = prompt 'Titel der Auswahlmöglichkeit: ', @title 
        Meteor.call 'updateOption', @, title
_.extend Template.radioFieldTable,
  valueTitle: () ->
    option = _.find @options, (option) => option._id is @value
    option?.title
