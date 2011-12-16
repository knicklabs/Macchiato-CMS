class Macchiato.Views.PostsItem extends Backbone.View
  events:
    "click .destroy": "destroy"
    
  tagName: "li"
  
  destroy: ->
    if confirm("Are you sure you want to delete this post?")
      if @model.get('id') == $('form#edit-post').attr('data-id')
        $('form#edit-post').parent().remove()
      @model.destroy
      this.remove()
      
      $('.alert-window').remove()
      alert = new Macchiato.Views.Alert({ class: "warning", message: "Your post was deleted. You can restore it if you made a mistake." })
      Macchiato.appBody.panes[2].prepend(alert.render().el)
      Macchiato.appBody.panes[2].scrollTop(0)
      
    return false
    
  render: ->
    $(this.el).html(_)
    $(this.el).html(JST["backbone/templates/posts/item"](@model.toJSON()))
    return this