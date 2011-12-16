class Macchiato.Views.PostsForm extends Backbone.View
  events:
    'click .add-meta-name': 'addMetaName'
    'click .add-custom-field': 'addCustomField'
    'click .remove-meta-name': 'removeMetaName'
    'click .remove-custom-field': 'removeCustomField'
    'click .save': 'save'
  
  initialize: ->
    _.bindAll(this, 'render')
    @options.post.bind('change', @render)
  
  render: ->
    $(@el).html(JST["backbone/templates/posts/form"](@options.post.toJSON()))
    return this
    
  addMetaName: ->
    $('form fieldset#edit-post-meta-names div.group-container').append(JST["backbone/templates/posts/meta_name"])
    return false
    
  addCustomField: ->
    $('form fieldset#edit-post-custom-fields div.group-container').append(JST["backbone/templates/posts/custom_field"])
    return false
    
  removeMetaName: (e)->
    item = e.currentTarget
    $(item).parent().parent().remove()  
    return false
    
  removeCustomField: (e)->
    item = e.currentTarget
    $(item).parent().parent().remove()
    return false
  
  save: ->
    self = @
    
    title = @$('[name="title"]').val()
    text = @$('[name="text"]').val()
    meta_names = []
    $('form fieldset#edit-post-meta-names div.group').each(->
      id = ""
      idStore = $(this).find('input[name="meta_names[][id]"]')
      id = idStore.val()
    
      key = ""
      keyStore = $(this).find('input[name="meta_names[][key]"]')
      key = keyStore.val()
      
      value = ""
      valueStore = $(this).find('input[name="meta_names[][value]"]')
      value = valueStore.val()
      
      del = ""
      deleteStore = $(this).find('input[name="meta_names[][_delete]"]')
      del = false
      if deleteStore.is(':checked')
        del = true
        
      meta_name = {
        id: id,
        key: key,
        value: value,
        _delete: del
      }
      
      meta_names.push(meta_name)
    )
    custom_fields = []
    $('form fieldset#edit-post-custom-fields div.group').each(->
      id = ""
      idStore = $(this).find('input[name="custom_fields[][id]"]')
      id = idStore.val()
      
      key = ""
      keyStore = $(this).find('input[name="custom_fields[][key]"]')
      key = keyStore.val()
      
      value = ""
      valueStore = $(this).find('input[name="custom_fields[][value]"]')
      value = valueStore.val()
      
      del = ""
      deleteStore = $(this).find('input[name="custom_fields[][_delete]"]')
      del = false
      if deleteStore.is(':checked')
        del = true
        
      custom_field = {
        id: id,
        key: key,
        value: value,
        _delete: del
      }
      
      custom_fields.push(custom_field)
    )
    
    self.options.post.save({
      title: title,
      text: text,
      meta_names: meta_names,
      custom_fields: custom_fields
    }, {
      success: (model, response)->
        self.options.post = model
        return false
      error: (model, response)->
        return false
    })
    return false

