define ['lib.nayjest/graphics/layers/dom/DomLayer', 'jquery'], (DomLayer, $)->
  defaults =
  color:'gray'
  borderColor:'red'
  borderWidth:1
  tag:'div'

  class DomRectLayer extends DomLayer
    constructor:(config)->
      options = $.extend defaults, config
      super options
      @setColor options.color
      @setBorderColor options.borderColor
    setColor:(color)->
      @color = color
      @$el.css 'background-color', color
    setBorderColor:(color)->
      @borderColor = color
      @$el.css 'border-color', color
    setBorderWidth:(width)->
      @width  = width
      @$el.css 'border-width', width+'px'




