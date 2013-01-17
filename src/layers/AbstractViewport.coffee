###
Abstract viewport class
Viewport is root layer in any scene
###
define [
  'components/graphics/lib/layers/AbstractLayer'
], (
  AbstractLayer
)->
  class AbstractViewport extends AbstractLayer
    constructor: (config)->

      super config
