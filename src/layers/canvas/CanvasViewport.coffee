###
Abstract viewport class
Viewport is root layer in any scene
###
define [
  'components/graphics/lib/layers/dom/DomLayer',
  'components/underscore/underscore'
], (
  DomLayer
)->
  class CanvasViewport extends DomLayer
    constructor: (config)->
      defaults =
        size: [$('body').width(), $('body').height()]
        context: CanvasViewport.CONTEXT.CANVAS_2D
      coreOptions =
        $el: $ '<canvas/>'
      finalConfig = _.defaults coreOptions, config, defaults
      super finalConfig
      @setContext finalConfig.context

    @CONTEXT:
      CANVAS_2D:'2d'

    setContext: (contextName)->
      @context = @$el.get(0).getContext contextName

    clear: ->
      @context.clearRect 0, 0, @getSize()[0], @getSize()[1]
      @

    redraw: ->
      @
        .clear()
        .redrawChildren()
