# The NewButton factory creates a new button.
class window.AppFactory.NewButton
  constructor: (@newButtonPane)->
    @newButton = ""
    
  make: (options)->
    @newButtonPane.html('<a href="#" class="button new">New</a>')
    @newButton = @newButtonPane.find('a')
    @newButton.hide()
    
  alter: (options)->
    options.href = options.href || '#'
    options.title = options.title || 'Create new'
    
    @newButton.attr('href', options.href)
    @newButton.attr('title', options.title)
    @newButton.show()
    
  hide: (options)->
    @newButton.hide()