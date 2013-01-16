###
module AbstractLayer
###
define [
  'components/Node/Node',
  'components/jquery/jquery'
], (
  Node
) ->
  _defaults =
    x: 0
    y: 0
    w: 100
    h: 100
    zIndex: 1
    angle: 0
    zoom: 1

  ###
  Base layer class
  @method #show()
  @method #hide()
  @method #getScreenPos()
  @method #getCenterScreenPos()
  ###
  class AbstractLayer extends Node

    ###
    @param {Object|null} config
    @option config {Array|null} offset [x,y] Offset in pixels
    @option config {Array|null} size [x,y] Size in pixels
    @option config {Number|null} zIndex css z-index of created canvas DOM Object
    @option config {Number|null} zoom
    @option config {Number|null} angle in degrees
    @option config {AbstractLayer|null} parent
    @option config {Array<AbstractLayer>|null} children
    ###
    constructor: (config = {}) ->
      super config.parent, config.children
      @setOffset config.offset or [_defaults.x, _defaults.y]
      @setSize config.size or [_defaults.w, _defaults.h]
      @setZIndex config.zIndex or _defaults.zIndex
      @setZoom config.zoom or _defaults.zoom
      @setAngle config.angle or _defaults.angle
      @ready = $.Deferred()
      if @isReadyAfterConstruct
        @ready.resolve @

    defaults: _defaults

    isReadyAfterConstruct: yes

    ###
    @param {Number} zIndex
    ###
    setZIndex: (@_zIndex) -> @

    getZIndex: -> @_zIndex

    setOffset: (offset) ->
      @_offset = offset.slice 0
      @

    getOffset: -> @_offset

    setSize: (size) ->
      @_size = size.slice 0
      @

    getSize: -> @_size

    ###
    @param {Number} angle in degrees
    ###
    setAngle: (@_angle)-> @

    getAngle: -> @_angle

    setZoom: (@_zoom)-> @

    getZoom: -> @_zoom

    ###
    @return {Array<Number>} [x,y]
    ###
    getAbsoluteOffset: ->
      layer = @
      x = @getOffset()[0]
      y = @getOffset()[1]
      while layer = layer.getParent()
        x += layer.getOffset()[0]
        y += layer.getOffset()[1]
      [x, y]

    getAbsoluteZoom: ->
      zoom = @_zoom
      layer = @
      zoom *= layer.getZoom()  while layer = layer.getParent()
      zoom

    ###
    Redraws layer
    ###
    redraw: ->
      #update children elements
      children = @getChildren()
      for child in children
        child.redraw()
      @

    # Method to free resources
    destroy: ->