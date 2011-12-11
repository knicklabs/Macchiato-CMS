# The Panes factory splits the application into vertical panes.
class window.AppFactory.Panes
  constructor: (@appWindow)->
    
    # The container is a reference to the selector that contains the pane.
    @container = ""
    
    # Panes is a reference to the selector for each pane placed inside the container.
    @panes = []

  split: (options)-> 
    self = @
    
    # Default values
    options.leftOffset = options.leftOffset || 0
    options.rightOffset = options.rightOffset || 0
    options.bottomOffset = options.bottomOffset || 0
    
    count = 1
    
    # Place the container inside the application window.
    @appWindow.append('<div id="'+options.id+'"></div>')
    
    @container = @appWindow.find('div#'+options.id)
    @container.addClass('panes')
    
    _.each(options.panes, (p)->
      # Place each pane into the container.
      self.container.append('<div id="'+p.id+'"></div>')
      
      pane = self.container.find('div#'+p.id)
      pane.addClass('pane')
    
      # Place the pane along the x-axis. 
      pane.css({
        position: "fixed",
        left: options.leftOffset + "px"
      })
      
      # Place the pane along the y-axis.
      if options.topOffset or options.topOffset == 0
        pane.css({ top: options.topOffset + "px" })
      if options.bottomOffset or options.bottomOffset == 0
        pane.css({ bottom: options.bottomOffset + "px" })
        
      # Give the pane a fixed height or allow it to stretch to some bottom.
      if !options.height
        pane.css({
          bottom: options.bottomOffset + "px"
        })
      else
        pane.css({
          height: options.height + "px"
        })
        
      # Give the pane a fixed width or allow it to stretch to the right if its the last one.
      if count == options.panes.length
        pane.css({
          right: options.rightOffset + "px"
        })
      else
        pane.css({
          width: p.width + "px"
        })
      
      # Configure the pane to the vertically scrollable or not.
      if p.verticalScroll
        pane.css({ "overflow-y": "auto" })
      else
        pane.css({ "overflow-y": "hidden" })
        
      # Configure the pane to be horizontally scrollable or not.
      if p.horizontalScroll
        pane.css({ "overflow-x": "auto" })
      else
        pane.css({ "overflow-x": "hidden" })
      
      # Group the panes so that multiple panes can be scripted.  
      if p.group
        pane.attr('data-group', p.group)
        
      options.leftOffset = options.leftOffset + p.width
      count = count + 1
      
      self.panes.push pane
    )
    

