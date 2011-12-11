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
      error: (model, response) ->
    })
    
  