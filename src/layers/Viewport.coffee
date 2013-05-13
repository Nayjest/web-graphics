###
Abstract viewport class
Viewport is root layer in any scene
###
define [
  'components/graphics/lib/layers/dom/AbstractDomLayer',
  'components/Vector2D/Vector2D',
], (
  AbstractDomLayer,
  Vector2D
)->
  class Viewport extends AbstractDomLayer

    @default:null

    @getDefault: ->
      @default ?= new @

    constructor: (config = {})->
      # First created viewport will be used as default
      @constructor.default ?= @
      $body = $ 'body'

      defaults =
        size:
          x:$body.width()
          y:$body.height()
        $el: $ '<div class="viewport" data-type="viewport" />'
        $parentEl: $body
      super  _.defaults config, defaults
      @$el.css {overflow:'hidden'}

    clear: ->
      @

    screenPosToViewport: (x, y)->
      domOffset = @$el.offset()
      res = new Vector2D(
        x - @size.x / 2 - domOffset.left,
        y - @size.y / 2 - domOffset.top
      )