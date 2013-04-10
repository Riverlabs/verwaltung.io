_.extend Template.fileFieldEdit,
  rendered: () ->
    filepicker.constructWidget @find('input[type=filepicker]')
  events:
    'change input[type=filepicker]': (event) ->
      Fields.update @_id, $set: value: event.fpfile
    'click .delete': (event) ->
      event.preventDefault()
      Fields.update @_id, $unset: value: 1

_.extend Template.fileField,
  rendered: () ->
    filepicker.constructWidget @find('input[type=filepicker]')
  events:
    'change input[type=filepicker]': (event) ->
      fields = {}
      fields["fields.#{@_id}"] = event.fpfile
      LibraryItems.update Meteor.router.pages().invocation().libraryItem,
        $set: fields
    'click .delete': (event) ->
      event.preventDefault()
      fields = {}
      fields["fields.#{@_id}"] = ''
      LibraryItems.update Meteor.router.pages().invocation().libraryItem,
        $set: fields
