class Macchiato.Views.PostsIndex extends Backbone.View
  events:
    'click article.resource.post': 'edit'
    
  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.posts.bind('reset', @addAll)
    @options.posts.bind('change', @render, this)
    @options.posts.bind('add', @render)
    @options.posts.bind('remove', @render)
    
  addAll: ->
    @options.posts.each(@addOne)
    
  addOne: (post)->
    view = new Macchiato.Views.PostsItem({ model: post })
    @$("ul").append(view.render().el)
    
  render: (item)->
    $(@el).html(JST["backbone/templates/posts/index"](posts: @options.posts.toJSON()))
    @addAll()
    
    if item 
      Macchiato.appNavigation.secondaryNavigationList.find('li').each(->
        $(this).removeClass("active")
        article = $(this).find('.resource')
        if $(article).attr('data-id') == item.get('id')
          $(this).addClass('active')
      )
    return this
    
    
    @navigationList = @navigationPane.find("ul")
    
  edit: (e) ->
    target = $(e.currentTarget)
    id = target.attr('data-id')
    view = new Macchiato.Views.PostsForm({ post: @options.posts.get(id) })
    Macchiato.appBody.panes[2].html(view.render().el)