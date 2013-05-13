###
Module DomLayer
@author Vitalii [Nayjest] Stepanenko <gmail@vitaliy.in>
###
define [
  'components/graphics/lib/layers/AbstractLayer',
  'components/graphics/lib/figures/dummyFigure',
  'components/graphics/lib/figures/Rectangle',
  'components/Vector2D/Vector2D',
  "components/jquery/jquery",
  "components/underscore/underscore"
], (
  AbstractLayer,
  dummyFigure,
  Rectangle,
  Vector2D
) ->
  class AbstractActiveLayer extends AbstractLayer

    _defaultFigureClass: Rectangle

    ###
    dummy prototype.figure will be used if layer isn't active
    ###
    figure: dummyFigure


    constructor: (config = {})->
      super config
      if config.active or config.figure
        _initActiveLayer config.figure
      else
        @active = false

    _initActiveLayer: (figureClass = null)->
      @active = yes
      _class = figureClass or @_defaultFigureClass
      @figure = new _class @
      @_eventHandlers = {}

    # Active layer

    on: (eventName, handler) ->
      @active or @_initActiveLayer()
      @_eventHandlers[eventName] ?= $.Callbacks()
      @_eventHandlers[eventName].add handler
      # @temp, there will be not only mouse events
      @_bindMouseEvent eventName, handler

    fireEvent:(eventName, options)->
      $callbacks = @_eventHandlers[eventName]
      if $callbacks
        $callbacks.fireWith @, options

    _mouseEventLayers = {}
    _hoveredLayer = null

    _bindMouseEvent: (eventName) ->
      if !_mouseEventLayers[eventName]
        _mouseEventLayers[eventName] = []
        $el = $ 'body'
        if eventName in ['mouseover','mouseout']
          $el.on 'mousemove', (event)->

            if _hoveredLayer
              l = _hoveredLayer
              mousePos = l.viewport.screenPosToViewport event.pageX, event.pageY
              #pos = _hoveredLayer.getCenterScreenPos()
              #if !((Math.abs(pos.x - event.offsetX) < _hoveredLayer.size.x / 2) and (Math.abs(pos.y - event.offsetY) < _hoveredLayer.size.y / 2))
              if !l.figure.isPointInside(mousePos)
                _hoveredLayer.fireEvent 'mouseout', [event]
                _hoveredLayer = null

            for l in _mouseEventLayers[eventName]
              if _hoveredLayer != l
                mousePos = l.viewport.screenPosToViewport event.pageX, event.pageY
                #pos = l.getCenterScreenPos()
                #if (Math.abs(pos.x - event.offsetX) < l.size.x / 2) and (Math.abs(pos.y - event.offsetY) < l.size.y / 2)
                if l.figure.isPointInside(mousePos)
                  if _hoveredLayer
                    _hoveredLayer.fireEvent 'mouseout', [event]
                  _hoveredLayer = l
                  l.fireEvent 'mouseover', [event]

                  break
        else
          $el.on eventName, (event)->
            for l in _mouseEventLayers[eventName]
              mousePos = l.viewport.screenPosToViewport event.pageX, event.pageY
              #pos = l.getCenterScreenPos()
              #if (Math.abs(pos.x - event.offsetX) < l.size.x / 2) and (Math.abs(pos.y - event.offsetY) < l.size.y / 2)
              if l.figure.isPointInside(mousePos)
                l.fireEvent eventName, [event]
                break
      _mouseEventLayers[eventName].push @
      # sort from higher to lower zIndexes
      _mouseEventLayers[eventName].sort (a,b)->
        if a.zIndex > b.zIndex
          return -1
        if a.zIndex < b.zIndex
          return 1
        0


