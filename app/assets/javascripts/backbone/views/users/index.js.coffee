class Macchiato.Views.UsersIndex extends Backbone.View
  events:
    'click article.resource.user': 'edit'

  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.users.bind('reset', @addAll)

  addAll: ->
    @options.users.each(@addOne)

  addOne: (user)->
    view = new Macchiato.Views.UsersItem( {model: user })
    @$("ul").append(view.render().el)

  render: ->
    $(@el).html(JST["backbone/templates/users/index"](users: @options.users.toJSON()))
    @addAll()
    return this

  edit: (e)->
    target = $(e.currentTarget)
    id = target.attr('data-id')
    Backbone.history.loadUrl('users/'+id+'/edit')
    return false