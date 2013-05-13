###
Module DomLayer
@author Vitalii [Nayjest] Stepanenko <gmail@vitaliy.in>
###
define ['components/graphics/lib/layers/dom/DomLayer'], (DomLayer)->
  "use strict"
  _defaults =
    color: 'gray'
    borderColor: 'red'
    borderWidth: 0

  class DomRectLayer extends DomLayer
    constructor: (config = {})->
      super config
      @setColor config.color or _defaults.color
      @setBorderColor config.borderColor or _defaults.borderColor
      @setBorderWidth config.borderWidth or _defaults.borderWidth

    setColor: (@_color)->
      @$el.css 'background-color', @_color

    setBorderColor: (@_borderColor)->
      @$el.css 'outline-color', @_borderColor

    setBorderWidth: (@_borderWidth)->
      if @_borderWidth
        @$el.css 'outline-style', 'solid'
      else
        @$el.css 'outline-style', 'none'
      @$el.css 'outline-width', @_borderWidth + 'px'




