# The FilterButton factory creates a filter button plus menu.
class window.AppFactory.FilterButton
  constructor: (@filterButtonPane)->
    @filterButton = ""

  make: (options)->
    @filterButtonPane.append('<a href="#" class="button filter">Filter</a>')
    @filterButton = @filterButtonPane.find('a.filter')

    # Append a modal window to the body
    $('#app').append('<div id="modal" class="reveal-modal"></div>')

    # Activate the modal on click
    @filterButton.bind('click', ->
      $('#modal').reveal({
        animation: 'fadeAndPop'
        animationspeed: 300
        closeOnBackgroundClick: true
        dismissModalClass: 'close-reveal-modal'
      })
      return false
    )

    @filterButton.hide()

  alter: (options)->
    $('#modal').html(JST[options.template](active: options.active))
    @filterButton.show()

  hide: (options)->
    @filterButton.hide()