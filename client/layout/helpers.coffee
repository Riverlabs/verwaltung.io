Handlebars.registerHelper 'formatNumber', (number, format) ->
  $.format.locale
    number: 
      format: '#,##0.####'
      groupingSeparator: '.'
      decimalSeparator: ','
  $.format.number parseFloat(number), format

Handlebars.registerHelper 'pluralize', (singular, plural, zero, count) ->
  return "#{singular}" if count is 1
  return "#{count} #{plural}" if count > 1
  return "#{zero}"
