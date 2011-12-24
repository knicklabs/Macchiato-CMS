# PostsRouter
#
# Nickolas Kenyeres (2011)
#
# The PostsRouter orchestrates all application states related to the management 
# of posts.

class Macchiato.Routers.Posts extends Backbone.Router
  # Note that we include aliases for all routes, so for new and new/ will both
  # work.
  routes: {
    'posts/new/': 'create'
    'posts/new': 'create'
    'posts/published': 'published'
    'posts/unpublished': 'unpublished'
    'posts/deleted': 'deleted'
    'posts/:id/edit/': 'edit'
    'posts/:id/edit': 'edit'
    'posts/': 'index'
    'posts': 'index'
  }
  
  initialize: ->
    # Nothing to do here... move along.
  
  # Brings the application up to state for this component.
  setUp: (options)->
    self = @
    
    # Enable the section
    Macchiato.appNavigation.activateSection(options.section)
    
    # Enable searching
    Macchiato.appSearch.alter(options.search)
    
    # Enable creation
    Macchiato.newButton.alter(options.newButton)
    
    # Enable filtering
    Macchiato.filterButton.alter(options.filterButton)
      
  # Tears down the current state of this component of the application.
  tearDown: (options)->
    Macchiato.appNavigation.deactivate({})  

  # Show all posts (except deleted). Involves adding a list to the secondary navigation pane.
  index: ->
    self = @
    @posts = new Macchiato.Collections.Posts
    @posts.fetch({
      success: (model, response)->
        self.view = new Macchiato.Views.PostsIndex({ posts: self.posts })
        
        # Render the view.
        Macchiato.appBody.panes[1].html(self.view.render().el)
        
        # Do additonal user interface set-up.
        self.setUp({
          section: { title: "Posts" }
          search: { action: "posts", placeholder: "Search posts..." }
          newButton: { href: "#posts/new", title: "Create New Post" }
          filterButton: { template: "backbone/templates/modals/posts", active: "all" }
        })
      error: (model, response)->
        # Something to do here some day.
    })
   
  # Show all published posts. Involves adding a list to the secondary navigation pane. 
  published: ->
    self = @
    @posts = new Macchiato.Collections.PublishedPosts
    @posts.fetch({
      success: (model, response)->
        self.view = new Macchiato.Views.PostsIndex({ posts: self.posts })
        
        # Render the view.
        Macchiato.appBody.panes[1].html(self.view.render().el)
        
        # Do additional user interface set-up.
        self.setUp({
          section: { title: "Posts" }
          search: { action: "posts", placeholder: "Search posts..." }
          newButton: { href: "#posts/new", title: "Create New Post" }
          filterButton: { template: "backbone/templates/modals/posts", active: "published" }
        })
      error: (model, response)->
        # Something to do here some day.
    })
  
  # Show all unpublished posts. Involves adding a list to the secondary navigation pane.  
  unpublished: ->
    self = @
    @posts = new Macchiato.Collections.UnpublishedPosts
    @posts.fetch({
      success: (model, response)->
        self.view = new Macchiato.Views.PostsIndex({ posts: self.posts })
        
        # Render the view.
        Macchiato.appBody.panes[1].html(self.view.render().el)
        
        # Do additional user interface set-up.
        self.setUp({
          section: { title: "Posts" }
          search: { action: "posts", placeholder: "Search posts..." }
          newButton: { href: "#posts/new", title: "Create New Post" }
          filterButton: { template: "backbone/templates/modals/posts", active: "unpublished" }
        })
      error: (model, response)->
        # Something to do here some day.
    })
   
  # Show all deleted posts. Involves adding a list to the secondary navigation pane. 
  deleted: ->
    self = @
    @posts = new Macchiato.Collections.DeletedPosts
    @posts.fetch({
      success: (model, response)->
        self.view = new Macchiato.Views.PostsIndex({ posts: self.posts })
      
        # Render the view.
        Macchiato.appBody.panes[1].html(self.view.render().el)
      
        # Do additional user interface set-up.
        self.setUp({
          section: { title: "Posts" }
          search: { action: "posts", placeholder: "Search posts..." }
          newButton: { href: "#posts/new", title: "Create New Post" }
          filterButton: { template: "backbone/templates/modals/posts", active: "deleted" }
        })
      error: (model, response)->
        # Something to do here some day.  
    })
  
  # Edit an existing post. Involves adding a form to the content pane.  
  edit: (id)->
    @post = @posts.get('id')
    @view = new Macchiato.Views.PostsForm({ post: @post })
    Macchiato.appBody.panes[2].html(@view.render().el)
    
    # Support file uploading for this form.
    FileHelper.supportDragAndDrop()
  
  # Create a new post. Involves adding a form to the content pane.  
  create: ->
    self = @
    @tearDown({})
    @post = new Macchiato.Models.Post
    @view = new Macchiato.Views.PostsForm({ post: @post })
    Macchiato.appBody.panes[2].html(@view.render().el) 
    
    # Support file uploading for this form.
    FileHelper.supportDragAndDrop()