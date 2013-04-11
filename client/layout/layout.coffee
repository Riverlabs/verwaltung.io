_.extend Template.layout,
  rendered: () ->
    $('abbr').timeago()
