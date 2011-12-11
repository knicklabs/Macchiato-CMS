class Macchiato.Models.Post extends Backbone.Model
  url: ->
    base = 'api/posts'
    if @.isNew()
      return base
    else if base.charAt(base.length - 1) == '/'
      return base + @.id
    else
      return base + '/' + @.id
  
  defaults: ->
    title: "",
    text: "",
    tags: [],
    published: true,
    meta_names: [
      {
        key: "",
        value: ""
      }
    ],
    custom_fields: [
      {
        key: "",
        value: ""
      }
    ]