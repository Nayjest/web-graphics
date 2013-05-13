###
Module DomLayer
@author Vitalii [Nayjest] Stepanenko <gmail@vitaliy.in>
###
define [
  'components/graphics/lib/layers/AbstractActiveLayer',
  'components/Vector2D/Vector2D',
  #"JqueryEventsMixin",
  "components/jquery/jquery",
  "components/underscore/underscore"
], (
AbstractLayer,
Vector2D
# JqueryEventsMixin
) ->
  "use strict"
  _radInDeg = Math.PI / 180
  defaults =
    getCss: ->
      position:'absolute'
      padding: 0
      margin: 0
      top:0
      left:0
    tag: 'div'
    get$el: ->
      $ "<#{@tag}/>"
    # getParent$el: -> $ 'body'
    getAttr: -> {}

  class AbstractDomLayer extends AbstractLayer
    ###
    @option config {Object|null} css DOM Element css
    @option config {Object|null} attr DOM Element attributes
    @option config {Object|null} $el DOM Element wrapped to jQuery object
    @option config {DomElement|jQuery|selector|null} domContainer
    ###
    constructor: (config)->

      @_createDomElement config
      super config

    _createDomElement: (config = {})->
      @$el = config.$el or defaults.get$el()
      if config.$parentEl
        @setParentEl  config.$parentEl
      @$el.css  _.defaults {}, config.css, defaults.getCss()
      @$el.attr _.defaults {}, config.attr, defaults.getAttr()
      @$el.get(0).layer = @

    ###
    Shows layer
    ###
    show: ->
      @$el.show()
      super()

    hide: ->
      @$el.hide()
      super()

    _getNonDomLayersOffset: ->
      pos = new Vector2D()
      for layer in @getParents()
        break if layer instanceof AbstractDomLayer
        pos.add layer.pos
      pos

    _calcDomOffset: ->
      parentOffset = @$parentEl.offset()
      parentOffset = new Vector2D parentOffset.left, parentOffset.top
      zoom = @getAbsoluteZoom()
      size = @size.clone().multiplyScalar zoom
      domParentSize = new Vector2D @$parentEl.width(), @$parentEl.height()
      innerTopRightPos = domParentSize.substract(size).multiplyScalar(0.5)
      if @angle
          d = size.magnitude()
          a = (90 - @angle % 90) * (Math.PI / 180)
          angleMod =
            x: (size.x - d * Math.cos(Math.asin(size.y / d) - a)) / 2
            y: (size.y - d * Math.sin(a + Math.acos(size.x / d))) / 2
          innerTopRightPos.add angleMod


      nonDomOffset = @_getNonDomLayersOffset()
      res = parentOffset.add(innerTopRightPos).add(@pos.clone().multiplyScalar(zoom)).add(nonDomOffset)
      left: res.x
      top: res.y

    redraw: ->
      val = "rotate(" + @angle + "deg)"
      @$el
      .offset(@_calcDomOffset())
      .width(@size.x * @zoom)
      .height(@size.y * @zoom)
      .css
        "-moz-transform": val
        "-webkit-transform": val
        "-o-transform": val
        transform: val
      super()

    setParentEl: ($parentEl) ->
      @$parentEl = $ $parentEl
      @$el.appendTo @$parentEl

    # @todo consider viewport, use it insted of $('body')
    setParent: (parent) ->
      super parent
      if parent instanceof AbstractDomLayer
        @setParentEl parent.$el
      else
        if !@$parentEl
          @setParentEl $('body')
      @

    destructor: ->
      @$el.detach()
      super()

    getScreenPos: ->
      offset = @$el.offset()
      new Vector2D( offset.left - window.pageXOffset, offset.top - window.pageYOffset )

    getCenterScreenPos: ->
      @getScreenPos().add(@size.clone().multiplyScalar(0.5))