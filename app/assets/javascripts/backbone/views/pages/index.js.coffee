class Macchiato.Views.PagesIndex extends Backbone.View
  events:
    'click article.resource.page': 'edit'

  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.pages.bind('reset', @addAll)

  addAll: ->
    @options.pages.each(@addOne)

  addOne: (page)->
    view = new Macchiato.Views.PagesItem({ model: page })
    @$("ul").append(view.render().el)

  render: ->
    $(@el).html(JST["backbone/templates/pages/index"](pages: @options.pages.toJSON()))
    @addAll()
    return this

  edit: (e) ->
    target = $(e.currentTarget)
    id = target.attr('data-id')
    Backbone.history.loadUrl('pages/'+id+'/edit')
    return false