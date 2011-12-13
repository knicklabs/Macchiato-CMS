class Macchiato.Routers.Users extends Backbone.Router
  routes: {
    'users/:id/edit/': 'edit'
    'users/:id/edit': 'edit'
    'users/': 'index'
    'users': 'index'
  }

  initialize: ->

  index: ->
    users = new Macchiato.Collections.Users
    users.fetch({
      success: (model, response) ->
        @view = new Macchiato.Views.UsersIndex({ users: users })
        Macchiato.appBody.panes[1].html(@view.render().el)

        # Enable searching
        if Macchiato.appSearch
          Macchiato.appSearch.alter({ action: "users", placeholder: "Search Users..." })
      error: (model, response) ->
    })
