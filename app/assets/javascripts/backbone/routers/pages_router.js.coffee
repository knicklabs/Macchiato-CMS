class Macchiato.Routers.Pages extends Backbone.Router
  routes: {
    'pages/:id/edit/': 'edit'
    'pages/:id/edit': 'edit'
    'pages/': 'index'
    'pages': 'index'
  }

  initialize: ->

  index: ->
    pages = new Macchiato.Collections.Pages
    pages.fetch({
      success: (model, response) ->
        @view = new Macchiato.Views.PagesIndex({ pages: pages })
        Macchiato.appBody.panes[1].html(@view.render().el)

        # Enable searching
        if Macchiato.appSearch
          Macchiato.appSearch.alter({ action: "pages", placeholder: "Search Pages..." })

      error: (model, response) ->
    })