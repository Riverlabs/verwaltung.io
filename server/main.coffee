# Fetch Singular nound form from canoo.net
# searchString = "Einladungen"
# getSingular = (search, query="http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20html%20where%20url%3D%22http%3A%2F%2Fwww.canoo.net%2Finflection%2F#{search}%3AN%22%20and%0A%20%20%20%20%20%20xpath%3D'%2F%2Fdiv%5B%40id%3D%22WordClass%22%5D%2Ftable%2Ftr%5B3%5D'&format=json&callback=") ->
#   result = Meteor.http.get query
#   result = result?.data?.query?.results?.tr?.td
#   definition = {}
#   definition.article = result[1]?.p if result
#   definition.noun = result[2]?.p if result
#   return definition if result   
# console.log getSingular(searchString)

Meteor.methods
  'updateOption': (option, title) ->
    #TODO: Check permissions
    Fields.update (options: option), $set: 'options.$.title': title
