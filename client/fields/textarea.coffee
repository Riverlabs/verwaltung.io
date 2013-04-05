replaceTextareaWithEditor = () ->
  CKEDITOR.replace @find('textarea')

Template.textareaField.rendered = Template.textareaFieldEdit.rendered = replaceTextareaWithEditor
  

Template.textareaFieldTable.count = () ->
  if @value
    words = @value.replace(/(<([^>]+)>)/ig," ")
    words = words.replace(/&nbsp;/gi," ")
    words = words.replace(/(^\s*)|(\s*$)/gi,"")
    words = words.replace(/[ ]{2,}/gi," ")
    words = words.replace(/\n /,"\n")
    count = words.split(' ').length
  return count
