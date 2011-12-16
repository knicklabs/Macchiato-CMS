class Macchiato.Views.PostsIndex extends Backbone.View
  events:
    'click article.resource.post': 'edit'
    
  initialize: ->
    self = @
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.posts.bind('reset', @addAll)
    @options.posts.bind('change', @render, this)
    @options.posts.bind('add', @render)
    @options.posts.bind('remove', @render)
    $('.button.new').click(->
      self.create()
    )
    
  addAll: ->
    @options.posts.each(@addOne)
    
  addOne: (post)->
    view = new Macchiato.Views.PostsItem({ model: post })
    @$("ul").append(view.render().el)
    
  render: (item)->
    $(@el).html(JST["backbone/templates/posts/index"](posts: @options.posts.toJSON()))
    @addAll()
    
    if item
      Macchiato.appNavigation.activateThis({ id: item.get('id') })
    return this
    
    
    @navigationList = @navigationPane.find("ul")
    
  edit: (e) ->
    target = $(e.currentTarget)
    id = target.attr('data-id')
    view = new Macchiato.Views.PostsForm({ post: @options.posts.get(id) })
    Macchiato.appBody.panes[2].html(view.render().el)
    
  create: ->
    # Deactivate active post in secondary navigation.
    if Macchiato.appNavigation
      Macchiato.appNavigation.deactivate({})
      
    post = new Macchiato.Models.Post
    view = new Macchiato.Views.PostsForm({ post: post })
    Macchiato.appBody.panes[2].html(view.render().el)
    return false