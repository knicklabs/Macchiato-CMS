# The Navigation factory creates a primary navigation list.
class window.AppFactory.Navigation
  constructor: (@navigationPane)->
    @navigationList = ""
    
  make: (options)->
    self = @
    
    @navigationPane.append("<ul></ul>")
    @navigationList = @navigationPane.find("ul")
    
    _.each(options.list, (l) ->
      l.title = l.title || l.name
      l.href = l.href || "#"
      self.navigationList.append('<li><a href="'+l.href+'" title="'+l.title+'">'+l.name+'</a></li>')
    )

    self.navigationList.find('a').live('click', ->
      self.navigationList.find('a').each(->
        $(this).removeClass('active')
      )
      $(this).addClass('active')
    )

