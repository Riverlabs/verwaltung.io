setLibrary = () ->
  @set 'library', @params._id

createLibrary = () ->
  library = Libraries.insert created: new Date()
  Meteor.go Meteor.editLibraryPath({_id: library})
  return @stop()
removeLibrary = () ->
  if confirm 'Wollen Sie diese Bibliothek wirklich unwiderruflich löschen?'
    Libraries.remove @params._id
    Meteor.go Meteor.dashboardPath()
    Session.set 'message', type: 'success', text: 'Die Bibliothek wurde erfolgreich gelöscht.'
  else
    Meteor.go Meteor.editLibraryPath({_id: @params._id})
  return @stop()

isPublicPage = (page) ->
  page in ['help']
isAuthenticationPage = (page) ->
  page in ['login', 'register', 'welcome']
logout = () ->
  @redirect Meteor.loginPath()
  Meteor.logout ->
    Session.set 'message', type: 'success', text: 'Erfolgreich abgemeldet.'


Meteor.pages
  '/': to: 'dashboard'
  '/register': to: 'register', layout: 'framelessLayout'
  '/login': to: 'login', layout: 'framelessLayout'
  '/logout': logout
  '/library/create': to: 'editLibrary', as: 'createLibrary', before: [createLibrary]
  '/library/:_id': to: 'library', before: [setLibrary]
  '/library/:_id/create': to: 'createLibraryItem', before: [setLibrary]
  '/library/:_id/edit': to: 'editLibrary', before: [setLibrary]
  '/library/:_id/form': to: 'editLibraryForm', before: [setLibrary]
  '/library/:_id/remove': to: 'dashboard', as: 'removeLibrary', before: [removeLibrary]
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

