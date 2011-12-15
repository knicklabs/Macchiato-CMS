class Macchiato.Routers.Posts extends Backbone.Router
  routes: {
    'posts/:id/edit/': 'edit'
    'posts/:id/edit': 'edit'
    'posts/': 'index'
    'posts': 'index'
  }
  
  initialize: ->
    
  index: ->
    posts = new Macchiato.Collections.Posts
    posts.fetch({
      success: (model, response) ->
        @view = new Macchiato.Views.PostsIndex({ posts: posts })
        Macchiato.appBody.panes[1].html(@view.render().el)

        # Enable searching
        if Macchiato.appSearch
          Macchiato.appSearch.alter({ action: "posts", placeholder: "Search Posts..." })
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
    
  