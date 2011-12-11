#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers

window.Macchiato =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  
  init: ->
    # Create the application header.
    @appHeader = new AppFactory.Panes($('#app'))
    @appHeader.split({
      id: 'header',
      height: 50,
      topOffset: 0,
      panes: [
        { id: "main-header", width: 300, group: "main" },
        { id: "secondary-header", width: 300, group: "secondary" },
        { id: "content-header", group: "content" }
      ]
    })
    
    # Draw the application body.
    @appBody = new AppFactory.Panes($('#app'))
    @appBody.split({
      id: 'body',
      topOffset: 50,
      bottomOffset: 40,
      panes: [
        { id: "main-navigation", width: 300, verticalScroll: true, horizontalScroll: true, group: "main" },
        { id: "secondary-navigation", width: 300, verticalScroll: true, horizontalScroll: true, group: "secondary" },
        { id: "content", verticalScroll: true, horizontalScroll: true, group: "content" }
      ]
    })
    
    # Create the application footer.
    @appFooter = new AppFactory.Panes($('#app'))
    @appFooter.split({
      id: 'footer',
      height: 40,
      bottomOffset: 0
      panes: [
        { id: "main-footer", width: 300, group: "main" },
        { id: "secondary-footer", width: 300, group: "secondary" },
        { id: "content-footer", group: "content" }
      ]
    })
    
    # Create the main navigation.
    @appNavigation = new AppFactory.Navigation(@appBody.panes[0])
    @appNavigation.make({
      list: [
        { name: "Posts", href: "#posts" },
        { name: "Pages", href: "#pages" }, 
        { name: "Images", href: "#images" },
        { name: "Users", href: "#users" },
        { name: "Settings", href: "#settings" }
      ]
    })

    new Macchiato.Routers.Posts
    try
      Backbone.history.start()
    catch error
      
$(document).ready ->
  Macchiato.init()