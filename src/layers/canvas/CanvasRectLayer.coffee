define ['components/graphics/lib/layers/canvas/CanvasLayer'], (CanvasLayer)->
  class CanvasRectLayer extends CanvasLayer

    _defaults =
      color: 'gray'
      borderColor: 'red'
      borderWidth: 0

    defaultDrawMethod: ->
      pos = @getAbsolutePos()
      @context.beginPath()
      @context.rect pos.x - @size.x/2, pos.y- @size.y/2, @size.x, @size.y
      @context.fillStyle = @color
      @context.fill()
      if @borderWidth
        @context.lineWidth = @borderWidth
        @context.strokeStyle = @borderColor
        @context.stroke()

    constructor:(config = {})->
      super config
      @setColor config.color or _defaults.color
      @setBorderColor config.borderColor or _defaults.borderColor
      @setBorderWidth config.borderWidth or _defaults.borderWidth

    setColor: (@color)->@
    setBorderColor: (@borderColor)->@
    setBorderWidth: (@borderWidth)->@