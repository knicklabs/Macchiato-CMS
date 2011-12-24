# The File factory enables client side file uploads.
class window.AppFactory.FileFactory
  constructor:->
    @upload = ""
  
  test: ->
    if (window.File && window.FileReader && window.FileList && window.Blob)
      return true
    else
      alert('File API is not fully supported in this browser.')
    return false
    
  handleFileSelect: (evt)->
    evt.stopPropagation()
    evt.preventDefault()
    
    files = evt.dataTransfer.files;
    @upload = files[0]
    
    output = []
    count = 0
    
    for file in files
      if !file.type.match('image.*')
        continue
      if count > 0
        break
      count = count + 1
      reader = new FileReader()
      reader.onload = ((f)->
        return ((e)->
          $('img.thumb').remove()
          $('#drop-zone span.message').remove()
          
          span = document.createElement('span')
          span.innerHTML = ['<img class="thumb" src="', e.target.result, '" title="', f.name, '">'].join('')
          document.getElementById('drop-zone').insertBefore(span, null)
        )
      )(file)
      document.getElementById('list').innerHTML = '<ul>'+output.join('')+'</ul>'  
  
  handleDragOver: (evt)->
    evt.stopPropagation()
    evt.preventDefault()
    
  supportDragAndDrop: ->
    dropZone = document.getElementById('drop-zone')
    dropZone.addEventListener('dragover', @handleDragOver, false)
    dropZone.addEventListener('drop', @handleFileSelect, false)