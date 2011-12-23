# Macchiato
#
# Nickolas Kenyeres (2011)
#
# The control panel for the content management system of the same name. The control panel is implemented 
# in JavaScript, for a desktop application-like look and feel. It iteracts through an API to persist the
# data in a MangoDB database. The API is implemented with Ruby on Rails.
#
# Below is the manifest for the Macchiato control panel. These scripts are pulled in:
#
#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views
#= require_tree ./routers
#
# And here is some initialization code to get the party started:

# Macchiato()
window.Macchiato =
  # Models are data structures that syncronize with a database through the API layer.
  Models: {}
  
  # Collections are... collections of models.
  Collections: {}
  
  # Routers are primarily used to create states in the application when URL's are called.
  Routers: {}
  
  # Views are what are normally called controllers in MVC. They interact with models and templates.
  Views: {}
  
  # Templates are what are normally called views in MVC. They display content, typically derived from models.
  Templates: {}
  
  # init()
  #
  # When Macchiato is initialized it draws the user interface, binds some events to user interface 
  # elements, and initializes the routers, which orchestrate the functionality of the various 
  # components of the Macchiato control panel. There is one router per component.
  #
  # The Macchiato control panel makes use of an AppFactory found in /app. The AppFactory is responsible
  # for the display and functionality of most of the user interface. It generalizes some user interface 
  # for a multi-panel application. It is not sufficiently generalized to act as a standalone library, 
  # though the ultimate goal is to roll a standalone library from it, to serve as a starting point for 
  # other applications that use a similar user interface (top bar, bottom bar, and multiple vertical 
  # panels).
  init: ->
    # Create the application header.
    @appHeader = new AppFactory.Panes($('#app'))
    @appHeader.split({
      id: 'header',
      height: 50,
      topOffset: 0,
      panes: [
        { id: "main-header", width: 200, group: "main" },
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
        { id: "main-navigation", width: 200, verticalScroll: true, horizontalScroll: true, group: "main" },
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
        { id: "main-footer", width: 200, group: "main" },
        { id: "secondary-footer", width: 300, group: "secondary" },
        { id: "content-footer", group: "content" }
      ]
    })
    
    # Create the main navigation.
    # The main navigation cycles through components of the Macchiato control panel, such as posts, pages, and users.
    # Generally, these relate to colletions.
    @appNavigation = new AppFactory.Navigation(@appBody.panes[0])
    @appNavigation.make({
      list: [
        { name: "Posts", href: "#posts" },        # Clicking this button will call the index method in the Posts router.
        { name: "Pages", href: "#pages" },        # Clicking this button will call the index method in the Pages router. 
        { name: "Images", href: "#images" },      # Clicking this button will call the index method in the Images router.
        { name: "Users", href: "#users" },        # Clicking this button will call the index method in the Users router.
        { name: "Settings", href: "#settings" }   # Clicking this button will call the index method in the Settings router.
      ]
    })

    # Activate the secondary navigation.
    # The secondary navigation cycles through the items belonging to a component, such as a list of individual posts.
    # Generally, these relate to models.
    @appNavigation.activate($('#secondary-navigation ul li'))

    # Create the search form.
    # The search form goes above the secondary navigation and is used to filter content in the secondary navigation.
    @appSearch = new AppFactory.Search(@appHeader.panes[1])
    @appSearch.make({})

    # Create the application logo - a purely decorative piece of the user interface.
    @appLogo = new AppFactory.Logo(@appHeader.panes[0])
    @appLogo.make({ title: "Macchiato" })
    
    # Make fieldset content expandable/collapsible.
    @fieldsetExpander = new AppFactory.FieldsetExpander()
    @fieldsetExpander.make({})
    
    # Create new button. This button is used to create new instances of models, such as new posts or users.
    @newButton = new AppFactory.NewButton(@appFooter.panes[1])
    @newButton.make({})

    # Create filter button. This button is used to bring up a list of filters that can be applied on items in the secondary navigation.
    @filterButton = new AppFactory.FilterButton(@appFooter.panes[1])
    @filterButton.make({})

    # The Posts router orchestrates the states of the application relevant to post management.
    @appPosts = new Macchiato.Routers.Posts
    
    # The Pages router orchestrates the states of the application relevant to page management.
    @appPages = new Macchiato.Routers.Pages
    
    # The Users router orchestrates the states of the application relevant to user management.
    @appUsers = new Macchiato.Routers.Users
    try
      Backbone.history.start()
    catch error
      
$(document).ready ->
  Macchiato.init()