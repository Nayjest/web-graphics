###
Abstract viewport class
Viewport is root layer in any scene
###
define [
  'components/graphics/lib/layers/dom/AbstractDomLayer'
], (
  AbstractDomLayer
)->
  class Viewport extends AbstractDomLayer
    @default:null
    @getDefault: ->
      @default ?= new @
    constructor: (config = {})->
      @constructor.default ?= @
      $body = $ 'body'

      defaults =
        size:
          x:$body.width()
          y:$body.height()
        $parentEl: $body
      super  _.defaults config, defaults
      @$el.css {overflow:'hidden'}

    clear: ->
      @
