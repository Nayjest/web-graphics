define [
  'components/graphics/lib/layers/AbstractLayer',
  'components/graphics/lib/layers/canvas/CanvasViewport',
  'components/Vector2D/Vector2D',
  'components/jquery/jquery',
  'components/underscore/underscore'
], (
AbstractLayer,
CanvasViewport,
Vector2D
# JqueryEventsMixin
) ->

  class CanvasLayer extends AbstractLayer
    viewportClass:CanvasViewport
    defaultDrawMethod: ->
        throw new Error "Draw method isn't specified."

    constructor: (config = {})->
      super config
      @drawMethod = config.drawMethod or @defaultDrawMethod
      @context = config.context or @viewport.context

    redraw: ->
      if @visible
        pos = @getAbsolutePos()
        @drawMethod()
        @redrawChildren()

    getAbsolutePos: ->
      super().add(@viewport.size.clone().divideScalar(2))

    # Active layer
    on: (eventName, handler) ->
      #@todo support custom events
      @_bindMouseEvent(eventName, handler)

    _bindMouseEvent: (eventName, handler) ->
      @viewport.$el.on eventName, (event)=>
        # @todo: implement geometry, different collision checks
        pos = @getAbsolutePos()
        if (Math.abs(pos.x - event.offsetX) < @size.x / 2) and (Math.abs(pos.y - event.offsetY) < @size.y / 2)
          handler.call @, event
