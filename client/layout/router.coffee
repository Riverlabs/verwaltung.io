setLibrary = () ->
  @set 'library', @params._id

setLibraryItem = () ->
  @set 'libraryItem', @params._id
  @set 'library', LibraryItems.findOne(@params._id).library

createLibrary = () ->
  library = Libraries.insert({})
  Meteor.go Meteor.editLibraryPath({_id: library})
  return @stop()

createLibraryItem = () ->
  fields = {}
  libraryFields = Fields.find(library: @params._id).fetch()
  _.each libraryFields, (field) ->
    fields[field._id] = field.value
  libraryItem = LibraryItems.insert 
    library: @params._id
    fields: fields
  Meteor.go Meteor.editLibraryItemPath({_id: libraryItem})
  return @stop()

removeLibrary = () ->
  if confirm 'Wollen Sie diese Bibliothek wirklich unwiderruflich löschen?'
    Libraries.remove @params._id
    Meteor.go Meteor.dashboardPath()
    Session.set 'message', type: 'success', text: 'Die Bibliothek wurde erfolgreich gelöscht.'
  else
    Meteor.go Meteor.editLibraryPath({_id: @params._id})
  return @stop()

removeLibraryItem = () ->
  libraryId = LibraryItems.findOne(@params._id).library
  if confirm 'Wollen Sie diesen Eintrag wirklich unwiderruflich löschen?'
    LibraryItems.remove @params._id
    Session.set 'message', type: 'success', text: 'Der Eintrag wurde erfolgreich gelöscht.'
  Meteor.go Meteor.libraryPath(_id: libraryId)
  return @stop()

isPublicPage = (page) ->
  page in ['help', 'helpHistory']

isAuthenticationPage = (page) ->
  page in ['login', 'register', 'welcome']

logout = () ->
  @redirect Meteor.loginPath()
  Meteor.logout ->
    Session.set 'message', type: 'success', text: 'Erfolgreich abgemeldet.'

Meteor.pages
  '/': to: 'dashboard'
  '/help': to: 'help'
  '/help/history': to: 'helpHistory'
  '/register': to: 'register', layout: 'framelessLayout'
  '/login': to: 'login', layout: 'framelessLayout'
  '/logout': logout
  '/library/create': to: 'editLibrary', as: 'createLibrary', before: [createLibrary]
  '/library/:_id': to: 'library', before: [setLibrary]
  '/library/:_id/edit': to: 'editLibrary', before: [setLibrary]
  '/library/:_id/form': to: 'editLibraryForm', before: [setLibrary]
  '/library/:_id/remove': to: 'dashboard', as: 'removeLibrary', before: [removeLibrary]
  '/library/:_id/create': to: 'editLibraryItem', as: 'createLibraryItem', before: [createLibraryItem]
  '/library/item/:_id/edit': to: 'editLibraryItem', before: [setLibraryItem]
  '/library/item/:_id/remove': to: 'library', as: 'removeLibraryItem', before: [removeLibraryItem]
  '*': to: 'notFound'
, defaults:
  layout: 'layout'
  before: () ->
    unless $.browser.webkit
      @template 'browserNotSupported'
      @layout 'framelessLayout'
      return @done()
    if Meteor.loggingIn()
      @template 'loading'
      @layout 'framelessLayout'
      return @done()
    if Meteor.userId()
      @redirect '/' if isAuthenticationPage @page.name
    else unless (isAuthenticationPage @page.name) or (isPublicPage @page.name)
      @template 'login'
      @layout 'framelessLayout'

