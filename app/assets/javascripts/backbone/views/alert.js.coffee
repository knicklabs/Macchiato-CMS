class Macchiato.Views.Alert extends Backbone.View
  tagName: "div"
  className: "alert-window"
    
  events:
    'click .close': 'exit'
  
  initialize: ->
    @options.message = @options.message || ""
    @options.class = @options.class || " "

  render: ->
    $(this.el).html(_)
    $(this.el).html(JST["backbone/templates/alerts/alert"]({message: @options.message, className: @options.class}))
    return this
    
  exit: ->
    @.remove()
    return false