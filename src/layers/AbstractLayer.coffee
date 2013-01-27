###
module AbstractLayer
@author Vitalii [Nayjest] Stepanenko <gmail@vitaliy.in>
###
define [
  'components/Node/Node',
  'components/Vector2D/Vector2D',
  'components/jquery/jquery'
], (Node, Vector2D) ->
  "use strict"

  ###
  Base layer class
  @method #show()
  @method #hide()
  @method #getScreenPos()
  @method #getCenterScreenPos()
  ###
  class AbstractLayer extends Node

  # Language helpers:
    get = (props) =>
      @:: __defineGetter__ name, getter for name, getter of props
    set = (props) =>
      @:: __defineSetter__ name, setter for name, setter of props

    TO_RADIANS = Math.PI / 180
    TO_DEGREES = 180 / Math.PI

    defaults =
      pos:
        x: 0
        y: 0
      size:
        x: 100
        y: 100
      zIndex: 1
      angle: 0
      zoom: 1

    ###
    @param {Object|null} config
    @option config {Vector2D|object|null} pos position
    @option config {Vector2D|object|null} size size
    @option config {Number|null} zIndex
    @option config {Number|null} zoom
    @option config {Number|null} angle in degrees
    @option config {AbstractLayer|null} parent
    @option config {Array<AbstractLayer>|null} children
    ###
    constructor: (config = {}) ->
      super config.parent, config.children
      @pos = Vector2D.cloneFrom config.pos or defaults.pos
      @size = Vector2D.cloneFrom config.size or defaults.size
      @zIndex = config.zIndex or defaults.zIndex
      @zoom = config.zoom or defaults.zoom
      if config.angle
        @angle = config.angle
      else
        if config.angleRad
          @angleRad = config.angleRad
        else
          @angle = defaults.angle
      @ready = $.Deferred()
      if @isReadyAfterConstruct
        @ready.resolve @

    isReadyAfterConstruct: yes

    get angle: -> @_angle
    set angle: (val) ->
      @_angle = val
      @_angleRad = val * TO_RADIANS

    get angleRad: -> @_angleRad
    set angleRad: (val)->
      @_angle = val
      @_angleRad = val * TO_DEGREES



    getAbsolutePos: ->
      pos = @pos.clone()
      pos.add layer.pos for layer in @getParents()
      pos

    getAbsoluteZoom: ->
      zoom = @zoom
      zoom *= layer.zoom for layer in @getParents()
      zoom

    ###
    Redraws layer
    ###
    redraw: ->
      @redrawChildren()

    redrawChildren: ->
      children = @getChildren()
      child.redraw() for child in children
      @

    # Method to free resources
    destructor: ->