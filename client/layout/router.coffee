setLibrary = () ->
  @set 'library', @params._id

setContact = () ->
  @set 'contact', Meteor.users.findOne @params._id

setLibraryItem = () ->
  @set 'libraryItem', @params._id
  @set 'library', LibraryItems.findOne(@params._id).library

createLibrary = () ->
  library = Libraries.insert({})
  Meteor.go Meteor.editLibraryPath({_id: library})
  woopraTracker.pushEvent name: 'createdLibrary', id: library
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
  woopraTracker.pushEvent name: 'createdLibraryItem', id: libraryItem
  return @stop()

removeLibrary = () ->
  if confirm 'Wollen Sie diese Bibliothek wirklich unwiderruflich löschen?'
    Libraries.remove @params._id
    Meteor.go Meteor.dashboardPath()
    Session.set 'message', type: 'success', text: 'Die Bibliothek wurde erfolgreich gelöscht.'
    woopraTracker.pushEvent name: 'removedLibrary', id: @params._id
  else
    Meteor.go Meteor.editLibraryPath({_id: @params._id})
  return @stop()

removeLibraryItem = () ->
  libraryId = LibraryItems.findOne(@params._id).library
  if confirm 'Wollen Sie diesen Eintrag wirklich unwiderruflich löschen?'
    LibraryItems.remove @params._id
    Session.set 'message', type: 'success', text: 'Der Eintrag wurde erfolgreich gelöscht.'
    woopraTracker.pushEvent name: 'removedLibraryItem', id: @params._id
  Meteor.go Meteor.libraryPath(_id: libraryId)
  return @stop()

isPublicPage = (page) ->
  page in ['help', 'helpHistory']

isAdminPage = (page) ->
  page in ['adminDashboard']

isAuthenticationPage = (page) ->
  page in ['login', 'register', 'welcome']

logout = () ->
  @redirect Meteor.loginPath()
  Meteor.logout ->
    woopraTracker.pushEvent name: 'loggingOut'
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
  '/contacts/:_id': to: 'showContact', before: [setContact]
  '/contacts/:_id/edit': to: 'editContact', before: [setContact]
  '/admin': to: 'adminDashboard'
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
      woopraTracker.pushEvent name: 'logginIn'
      return @done()
    if Meteor.userId()
      Intercom 'update',
        path: Meteor.router.path()
      @redirect '/' if isAuthenticationPage @page.name or (isAdminPage @page.name and not Meteor.user().admin)
    else unless (isAuthenticationPage @page.name) or (isPublicPage @page.name)
      @template 'login'
      @layout 'framelessLayout'

Meteor.autorun () ->
  if Meteor.user()

    user =         
      email: Meteor.user().emails?[0]?.address
      name: Meteor.user().profile.name
      created_at: Math.floor Meteor.user().createdAt/1000
      path: Meteor.router.path()
      user_id: Meteor.userId()
    woopraTracker.addVisitorProperty 'name', Meteor.user().profile.name
    woopraTracker.addVisitorProperty 'email', Meteor.user().emails?[0]?.address
    # woopraTracker.trackPageview
    #   url: Meteor.router.path()
    if window.IntercomActive
      Intercom 'update', user
    else
      window.IntercomActive = true
      Intercom 'boot', _.extend user, app_id: 'nq381rbw'

        # email: 'john.doe@example.com'
        # created_at: 1234567890
        # name: 'John Doe'
        # user_id: '9876'

woopraReady = (tracker) ->
  tracker.setDomain('verwaltung.io')
#   tracker.setIdleTimeout(1800000)

#   # tracker.addVisitorProperty('name', '$account.name');
#   # tracker.addVisitorProperty('email', '$account.email');
#   # tracker.addVisitorProperty('company', '$account.company');
#   # woopraTracker.pushEvent(event)

  # tracker.track()
  return false

