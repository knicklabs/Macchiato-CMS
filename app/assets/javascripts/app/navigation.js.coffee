# The Navigation factory creates a primary navigation list.
class window.AppFactory.Navigation
  constructor: (@navigationPane)->
    @navigationList = ""
    @secondaryNavigationList = ""
    
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

  activateSection: (options)->
    $('#main-navigation ul li a').each(->
      $(this).removeClass('active')
      if $(this).attr('title') == options.title
        $(this).addClass('active')  
    )

  activate: ($el)->
    @secondaryNavigationList = $el.parent()
    $el.live('click', ->
      $(this).parent().find('li').each(->
        $(this).removeClass('active')
      )
      $(this).addClass('active')
    )
    
  deactivate: (options)->
    $('#secondary-navigation ul li').each(->
      $(this).removeClass('active')
    )
    
  activateThis: (options)->
    @deactivate
    $('#secondary-navigation ul li').each(->
      if $(this).find('article').attr('data-id') == options.id
        $(this).addClass('active')
    )
