class Macchiato.Views.PostsIndex extends Backbone.View
  events:
    'click article.resource.post': 'edit'
    
  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.posts.bind('reset', @addAll)
    
  addAll: ->
    @options.posts.each(@addOne)
    
  addOne: (post)->
    view = new Macchiato.Views.PostsItem({ model: post })
    @$("ul").append(view.render().el)
    
  render: ->
    $(@el).html(JST["backbone/templates/posts/index"](posts: @options.posts.toJSON()))
    @addAll()
    return this
    
  edit: (e) ->
    target = $(e.currentTarget)
    id = target.attr('data-id')
    Backbone.history.loadUrl('posts/'+id+'/edit')
    return false