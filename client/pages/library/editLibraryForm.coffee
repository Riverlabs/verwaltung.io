_.extend Template.editLibraryForm, 
  library: () ->
    Libraries.findOne(Meteor.router.pages().invocation().library)
  fields: () ->
    Fields.find (library: @_id), (sort: created: 1)
  events: 
    'click #addInput': () ->
      Fields.insert 
        library: Meteor.router.pages().invocation().library
        type: $('#addInputType').val()
        created: new Date()
    # 'submit form': (event) ->
    #   console.log @
    #   event.preventDefault()
      # Libraries.update Meteor.router.pages().invocation().library, 
      #   $set: $('form').toObject(), 
      #   () ->
      #     Session.set 'message', type: 'success', text: 'Ihre Änderungen wurden erfolgreich gespeichert.'

_.extend Template.editLibraryFormField, 
  field: () ->
    if Template["#{@type}FieldEdit"]
      Template["#{@type}FieldEdit"](@)
    else
      Template.textFieldEdit(@)
  events: 
    'keyup input, change input, keyup textarea, change textarea': (event, template) ->
      Fields.update @_id, $set: $(template.firstNode).toObject(skipEmpty: false)
    'click .remove': () ->
      if confirm 'Wollen Sie dieses Feld wirklich unwiderruflich löschen? Beachten Sie: Diese Aktion kann die Darstellung der bestehenden Einträge beeinflussen.'
        Fields.remove @_id
