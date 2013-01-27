###
Abstract viewport class
Viewport is root layer in any scene
###
define [
  'components/graphics/lib/layers/Viewport',
  'components/underscore/underscore'
], (
  Viewport
)->
  class CanvasViewport extends Viewport
    constructor: (config)->
      defaults =
        context: CanvasViewport.CONTEXT.CANVAS_2D
      coreOptions =
        $el: $ '<canvas/>'
      finalConfig = _.defaults coreOptions, config, defaults
      super finalConfig
      @setContext finalConfig.context
      @$el.get(0).width = @size.x
      @$el.get(0).height = @size.y


    @CONTEXT:
      CANVAS_2D:'2d'

    setContext: (contextName)->
      @context = @$el.get(0).getContext contextName

    clear: ->
      @context.clearRect 0, 0, @size.x, @size.y
      super()

    redraw: ->
      @
        .clear()
        .redrawChildren()
