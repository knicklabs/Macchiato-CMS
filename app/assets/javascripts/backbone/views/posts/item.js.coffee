class Macchiato.Views.PostsItem extends Backbone.View
  events:
    "click .destroy": "destroy"
    
  tagName: "li"
  
  destroy: ->
    @model.destroy
    this.remove()
    return false
    
  render: ->
    $(this.el).html(_)
    $(this.el).html(JST["backbone/templates/posts/item"](@model.toJSON()))
    return this