class Macchiato.Routers.Posts extends Backbone.Router
  routes: {
    'posts/new/': 'create'
    'posts/new': 'create'
    'posts/:id/edit/': 'edit'
    'posts/:id/edit': 'edit'
    'posts/': 'index'
    'posts': 'index'
  }
  
  initialize: ->
    
  index: ->
    self = @
    posts = new Macchiato.Collections.Posts
    posts.fetch({
      success: (model, response) ->
        @view = new Macchiato.Views.PostsIndex({ posts: posts })
        Macchiato.appBody.panes[1].html(@view.render().el)

        # Enable the section
        if Macchiato.appNavigation
          Macchiato.appNavigation.activateSection({title: "Posts"})

        # Enable searching
        if Macchiato.appSearch
          Macchiato.appSearch.alter({ action: "posts", placeholder: "Search Posts..." })
          
        # Enable creation
        if Macchiato.newButton
          Macchiato.newButton.alter({ href: "#posts/new", title: "Create New Post" })
          
        # Load the first post.
        if posts.models.length > 0
          model = posts.models[0]
          self.edit(model.get('id'))
          if Macchiato.appNavigation
            Macchiato.appNavigation.activateThis({id: model.get('id')})  
          
      error: (model, response) ->
    })
    
  edit: (id)->
    post = new Macchiato.Models.Post({ id: id })
    post.fetch({
      success: (model, response)->
        @view = new Macchiato.Views.PostsForm({ post: post })
        Macchiato.appBody.panes[2].html(@view.render().el)
      error: (model, response)->
    })
    
  create: ->
    # Deactivate active post in secondary navigation.
    if Macchiato.appNavigation
      Macchiato.appNavigation.deactivate({})
    
    post = new Macchiato.Models.Post
    @view = new Macchiato.Views.PostsForm({ post: post })
    Macchiato.appBody.panes[2].html(@view.render().el)
    
  