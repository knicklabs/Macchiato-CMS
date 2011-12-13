# The Logo factory creates a logo.
class window.AppFactory.Logo
  constructor: (@logoPane)->
    @logo = ""

  make: (options)->
    @logoPane.html('<h1>'+options.title+'</h1>')
    @logo = @logoPane.find('h1')
