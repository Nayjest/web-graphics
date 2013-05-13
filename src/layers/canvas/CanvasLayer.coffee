define [
  'components/graphics/lib/layers/AbstractActiveLayer',
  'components/graphics/lib/layers/canvas/CanvasViewport',
  'components/Vector2D/Vector2D',
  'components/jquery/jquery',
  'components/underscore/underscore'
], (
  AbstractActiveLayer,
  CanvasViewport,
  Vector2D
  # JqueryEventsMixin
) ->

  class CanvasLayer extends AbstractActiveLayer
    viewportClass:CanvasViewport
    defaultDrawMethod: ->
        throw new Error "Draw method isn't specified."

    constructor: (config = {})->
      super config
      @drawMethod = config.drawMethod or @defaultDrawMethod
      @context = config.context or @viewport.context

    redraw: ->
      if @visible
        pos = @getDrawPos()
        @context.translate pos.x, pos.y
        @context.rotate @angleRad
        @context.translate -pos.x, -pos.y
        @drawMethod()
        @redrawChildren()
        @context.translate pos.x, pos.y
        @context.rotate -@angleRad
        @context.translate -pos.x, -pos.y


    # Position of layer center on canvas
    getDrawPos: ->
      @getAbsolutePos().add(@viewport.size.clone().divideScalar(2))

    getScreenPos: ->
      @getCenterScreenPos().substract(@size.clone().multiplyScalar(0.5))

    getCenterScreenPos: ->
      domOffset = @viewport.$el.offset()
      @getDrawPos().add(
        x: domOffset.left - window.pageXOffset
        y: domOffset.top  - window.pageYOffset
      )
      @getDrawPos()

