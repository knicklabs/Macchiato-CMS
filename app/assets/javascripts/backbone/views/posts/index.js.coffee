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
    post = @options.posts.get(id)
    view = new Macchiato.Views.PostsForm({ post: post })
    Macchiato.appBody.panes[2].html(view.render().el)
    
    if typeof(post.get('deleted_at')) != 'undefined' and post.get('deleted_at') != null
      $('form#edit-post input').attr('disabled', 'disabled')
      $('form#edit-post textarea').attr('disabled', 'disabled')
      $('form#edit-post button').remove()
      $('form#edit-post a').remove()
      $('form#edit-post .actions').remove()
      $('.alert-window').remove()
      alert = new Macchiato.Views.Alert({ class: 'warning', message: 'This post was deleted. You can view it but you will need to restore it in order to edit it.'})
      Macchiato.appBody.panes[2].prepend(alert.render().el)
      Macchiato.appBody.panes[2].scrollTop()
    
  create: ->
    # Deactivate active post in secondary navigation.
    if Macchiato.appNavigation
      Macchiato.appNavigation.deactivate({})
      
    post = new Macchiato.Models.Post
    view = new Macchiato.Views.PostsForm({ post: post })
    Macchiato.appBody.panes[2].html(view.render().el)
    return false