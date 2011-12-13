# The Search factory creates a search form.
class window.AppFactory.Search
  constructor: (@searchPane)->
    @searchForm = ""

  make: (options)->
    self = @

    @searchPane.append('<form id="search" action="" method="POST">')
    @searchForm = @searchPane.find("form")

    @searchForm.html('<input type="text" class="search" placeholder="Search..." value="" name="q">')
    @searchForm.submit(->
      query = self.searchForm.find('input[name="q"]').val()
      if Macchiato.Collections.SearchPosts and self.searchForm.attr('action') == "posts"
        posts = new Macchiato.Collections.SearchPosts
        posts.fetch({
          data: $.param({ q: query }),
          success: ->
            view = new Macchiato.Views.PostsIndex({ posts: posts })
            Macchiato.appBody.panes[1].html(view.render().el)
          error: ->
        })
       else if Macchiato.Collections.SearchPages and self.searchForm.attr('action') == "pages"
        pages = new Macchiato.Collections.SearchPages
        pages.fetch({
          data: $.param({ q: query }),
          success: ->
            view = new Macchiato.Views.PagesIndex({ pages: pages })
            Macchiato.appBody.panes[1].html(view.render().el)
          error: ->
        })
      else if Macchiato.Collections.SearchUsers and self.searchForm.attr('action') == "users"
        users = new Macchiato.Collections.SearchUsers
        users.fetch({
          data: $.param({ q: query }),
          success: ->
            view = new Macchiato.Views.UsersIndex({ users: users })
            Macchiato.appBody.panes[1].html(view.render().el)
          error: ->
        })
      return false
    )

  alter: (options)->
    options.action = options.action || ""
    options.placeholder = options.placeholder || ""

    @searchForm.attr('action', options.action)
    @searchForm.find('input.search').attr('placeholder', options.placeholder)
