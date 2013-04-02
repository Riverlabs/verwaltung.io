setLibrary = () ->
  @set 'library', @params._id

# makePrivate = () ->
#   unless Meteor.user()
#     Meteor.go('/login')

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
  '/library/:_id': to: 'library', before: [setLibrary]
  '/library/:_id/create': to: 'createLibraryItem', before: [setLibrary]
  '/library/:_id/edit': to: 'editLibrary', before: [setLibrary]
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

