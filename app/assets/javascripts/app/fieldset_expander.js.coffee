# The FieldsetExpander factory makes fieldset content expandable and collapsible.
class window.AppFactory.FieldsetExpander
  make: (options)->
    $('#body form fieldset h5').live('click', ->
      fieldset = $(this).parent()
      content = $(this).find('> div')
      if fieldset.attr('class') == 'expanded'
        $(fieldset).removeClass('expanded')
        $(fieldset).addClass('collapsed')
      else
        $(fieldset).removeClass('collapsed')
        $(fieldset).addClass('expanded')
    )