_.extend Template.layout,
  rendered: () ->
    $('abbr').timeago()

_.extend Template.framelessLayout,
  rendered: () ->
    $('abbr').timeago()
