define ['components/graphics/lib/layers/DomLayer'], (DomLayer)->

  _defaults =
    color: 'gray'
    borderColor: 'red'
    borderWidth: 1

  class DomRectLayer extends DomLayer
    constructor: (config = {})->
      super config
      @setColor config.color or _defaults.color
      @setBorderColor config.borderColor or _defaults.borderColor
      @setBorderWidth config.borderWidth or _defaults.borderWidth

    setColor: (@_color)->
      @$el.css 'background-color', @_color

    setBorderColor: (@_borderColor)->
      @$el.css 'border-color', @_borderColor

    setBorderWidth: (@_borderWidth)->
      @$el.css 'border-width', @_borderWidth + 'px'




