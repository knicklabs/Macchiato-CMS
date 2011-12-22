# The Panes factory splits the application into vertical panes.
class window.AppFactory.Panes
  constructor: (@appWindow)->
    self = @

    # The container is a reference to the selector that contains the pane.
    @container = ""
    
    # Panes is a reference to the selector for each pane placed inside the container.
    @panes = []

    # GroupsX is an array of groups and their X coordinate.
    @groupsX = []

    # GroupsW is an array of groups and their widths.
    @groupsW = []

    # Flags whether the panes need to be restored (because one is collapsed).
    @restore = false

    $('[data-collapse-group]').live('click', ->
      if self.restore
        # Restore all the panes.
        self.restoreGroups({})
      else
        # Collapse one pane.
        group = $(this).attr('data-collapse-group')
        self.collapseGroup({ group: group })
      return false
    )

  collapseGroup: (options) ->
    self = @
    targetGroup = options.group || null

    if typeof(targetGroup) == 'undefined'
      # Abort the operation if the target group is not found.
      return

    _.each(@panes, (pane)->
      if $(pane).attr('data-group') == targetGroup
        console.log(self.groupsW)
        pos = 0 - self.groupsW[targetGroup]
        $(pane).animate({
          left: pos + 'px'
        }, {
          duration: 300,
          specialEasing: {
            left: 'linear'
          }
        })
      else
        $(pane).animate({
          left: (self.groupsX[$(pane).attr('data-group')] - self.groupsW[targetGroup]) + "px" 
        }, {
          duration: 300,
          specialEasing: {
            left: 'linear'
          }
        })
    )

    @restore = true
    return false

  restoreGroups: (options) ->
    self = @
    _.each(@panes, (pane)->
      pos = self.groupsX[pane.attr('data-group')]
      $(pane).animate({
        left: pos + "px"
      }, {
        duration: 300,
        specialEasing: {
          left: 'linear'
        }
      })
    )
    @restore = false

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
      self.groupsX[p.group] = options.leftOffset
      self.groupsW[p.group] = p.width

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
    

