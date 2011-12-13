class Macchiato.Models.User extends Backbone.Model
  url: ->
    base = 'api/pages'
    if @.isNew()
      return base
    else if base.charAt(base.length - 1) == '/'
      return base + @.id
    else
      return base + '/' + @.id