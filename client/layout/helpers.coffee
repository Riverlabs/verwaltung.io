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
