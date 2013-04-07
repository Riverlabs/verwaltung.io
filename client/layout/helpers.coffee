Handlebars.registerHelper 'formatNumber', (number = 0, format) ->
  $.format.locale
    number: 
      format: '#,##0.####'
      groupingSeparator: '.'
      decimalSeparator: ','
  $.format.number parseFloat(number), format

Handlebars.registerHelper 'pluralize', (singular, plural, zero, count) ->
  return "#{singular}" if count is 1
  return "#{count} #{plural}" if count > 0
  return "#{zero}"

class Version
  constructor: (major='0.0.0', minor, patch) ->
    if _.isString major
      version = major.split('.')
      @major = parseInt(version[0])
      @minor = parseInt(version[1])
      @patch = parseInt(version[2])
    else if _.isObject major
      _.extend @, major
  toString: () ->
    "#{@major}.#{@minor}.#{@patch}"

# Handlebars.registerHelper 'versions', () ->
#   Session.get 'versions'

Handlebars.registerHelper 'currentVersion', () ->
  new Version Session.get('versions')[0]

Meteor.autorun () ->
  versions = HelpHistory.find
    idList: 
      $exists: false 
    name: /Version */i
  .fetch()
  versions = _.map versions, (version) ->
    match = /[\.0-9]+/.exec version.name
    return new Version match[0]
  sortedVersions = versions.sort (a, b) ->
    a = a.major*100000 + a.minor*1000 + a.patch
    b = b.major*100000 + b.minor*1000 + b.patch
    return b - a
  Session.set 'versions', sortedVersions
