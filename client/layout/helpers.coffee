Handlebars.registerHelper 'formatNumber', (number = 0, format) ->
  $.format.locale
    number: 
      format: '#,##0.####'
      groupingSeparator: '.'
      decimalSeparator: ','
  $.format.number parseFloat(number), format

Handlebars.registerHelper 'formatFileSize', (filesize = 0) ->
  suffix = ["Bytes", "KB", "MB", "GB", "TB", "PB"]
  tier = 0
  while filesize >= 1024
    filesize = filesize / 1024
    tier++
  filesize = Math.round(filesize * 10) / 10
  return "#{filesize} #{suffix[tier]}"

Handlebars.registerHelper 'pluralize', (singular, plural, zero, count) ->
  return "#{singular}" if count is 1
  return "#{count} #{plural}" if count > 0
  return "#{zero}"

class Version
  constructor: (version='0.0.0', @closed) ->
    if _.isString version
      version = version.split('.')
      @major = parseInt(version[0])
      @minor = parseInt(version[1])
      @patch = parseInt(version[2])
    else if _.isObject version
      _.extend @, version
  toString: () ->
    "#{@major}.#{@minor}.#{@patch}"

# Handlebars.registerHelper 'versions', () ->
#   Session.get 'versions'

Handlebars.registerHelper 'currentVersion', () ->
  versions = _.where Session.get('versions'), closed: true
  new Version versions[0]

Handlebars.registerHelper 'session', (title) ->
  Session.get title

Meteor.autorun () ->
  versions = HelpHistory.find
    idList: 
      $exists: false 
    name: /Version */i
  .fetch()
  versions = _.map versions, (version) ->
    match = /[\.0-9]+/.exec version.name
    return new Version match[0], version.closed
  sortedVersions = versions.sort (a, b) ->
    a = a.major*100000 + a.minor*1000 + a.patch
    b = b.major*100000 + b.minor*1000 + b.patch
    return b - a
  Session.set 'versions', sortedVersions
