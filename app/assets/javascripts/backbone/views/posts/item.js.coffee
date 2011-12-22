class Macchiato.Views.PostsItem extends Backbone.View
  events:
    "click .destroy": "destroy"
    "click .restore": "restore"
    
  tagName: "li"
  
  destroy: ->
    self = @
    
    if confirm("Are you sure you want to delete this post?")
      if @model.get('id') == $('form#edit-post').attr('data-id')
        $('form#edit-post').parent().remove()

      # We need to explicitly reset the collection url in case we are using one of the modified collections.
      if typeof(@model.collection) != 'undefined'
        @model.collection.url = '/api/posts'
        
      @model.destroy({
        success: ->
          self.remove()
          $('.alert-window').remove()
          alert = new Macchiato.Views.Alert({ class: 'warning', message: 'Your post was successfully deleted.' })
          Macchiato.appBody.panes[2].prepend(alert.render().el)
          Macchiato.appBody.panes[2].scrollTop()
        error: ->
          $('.alert-window').remove()
          alert = new Macchiato.Views.Alert({ class: 'error', message: 'Ooops. We could not delete that. Try again later.' })
          Macchiato.appBody.panes[2].prepend(alert.render().el)
          Macchiato.appBody.panes[2].scrollTop()
      })
      
    return false
    
  restore: ->
    self = @
    
    if confirm("Are you sure you want to restore this post?")
      $.ajax({
        type: "PUT"
        url: "/api/posts/"+self.model.get('id')+"/restore"
        success: ->
          self.remove()
          if self.model.get('id') == $('form#edit-post').attr('data-id')
            $('form#edit-post').parent().remove()
          $('.alert-window').remove()
          alert = new Macchiato.Views.Alert({ class: 'success', message: "Your post was successfully restored." })
          Macchiato.appBody.panes[2].prepend(alert.render().el)
          Macchiato.appBody.panes[2].scrollTop()
        error: ->
          $('.alert-window').remove()
          alert = new Macchiato.Views.Alert({ class: 'error', message: "Ooops. We could not restore that. Try again later." })
          Macchiato.appBody.panes[2].prepend(alert.render().el)
          Macchiato.appBody.panes[2].scrollTop()
      })
    
    return false
    
  render: ->
    $(this.el).html(_)
    $(this.el).html(JST["backbone/templates/posts/item"](@model.toJSON()))
    return this