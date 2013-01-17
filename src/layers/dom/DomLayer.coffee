define [
  'components/graphics/lib/layers/AbstractLayer',
  #"JqueryEventsMixin",
  "components/jquery/jquery",
  "components/underscore/underscore"
], (
  AbstractLayer,
  # JqueryEventsMixin
) ->
  _radInDeg = Math.PI / 180
  _defaults =
    getCss: ->
      outline: "1px dotted gray"
    tag: 'div'
    get$el: ->
      $ "<#{@tag}/>"
    # getParent$el: -> $ 'body'
    getAttr: -> {}

  class DomLayer extends AbstractLayer

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
      @$el = config.$el or _defaults.get$el()
      if config.$parentEl
        @_setParentEl  config.$parentEl
      @$el.css  _.defaults {}, config.css, _defaults.getCss()
      @$el.attr _.defaults {}, config.attr, _defaults.getAttr()
      @$el.get(0).layer = @

    ###
    Shows layer
    ###
    show: ->
      @$el.show()
      @

    hide: ->
      @$el.hide()
      @

    _getNonDomLayersOffset: ->
      parents = @getParents()
      x = 0
      y = 0
      for paret in parents
        if parent instanceof DomLayer
          break
        x+= parent.offset[0]
        y+= parent.offset[1]
      [x, y]

    _calcDomOffset: ->
      parentOffset = @$parentEl.offset()
      zoom = @getAbsoluteZoom()
      w = @getSize()[0] * zoom
      h = @getSize()[1] * zoom
      innerTopRightPos = [ (@$parentEl.width() - w) / 2, (@$parentEl.height() - h) / 2 ]
      a = @getAngle()
      if a
        d = Math.sqrt(w * w + h * h)
        a = (90 - a % 90) * _radInDeg
        innerTopRightPos[1] += (h - d * Math.sin(a + Math.acos(w / d))) / 2
        innerTopRightPos[0] += (w - d * Math.cos(Math.asin(h / d) - a)) / 2
      nonDomOffset = @_getNonDomLayersOffset()
      left: parentOffset.left + innerTopRightPos[0] + @getOffset()[0] * zoom + nonDomOffset[0]
      top: parentOffset.top + innerTopRightPos[1] + @getOffset()[1] * zoom + nonDomOffset[1]

    redraw: ->
      val = "rotate(" + @getAngle() + "deg)"
      @$el
        .offset(@_calcDomOffset())
        .width(@getSize()[0] * @getZoom())
        .height(@getSize()[1] * @getZoom())
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
      if parent instanceof DomLayer
        @setParentEl parent.$el
      else
        if !@$parentEl
          @setParentEl $('body')
      @

    destroy: ->
      @$el.detach()
      super()

    getScreenPos: ->
      offset = @$el.offset()
      [ offset.left - window.pageXOffset, offset.top - window.pageYOffset ]

    getCenterScreenPos: ->
      pos = @getScreenPos()
      [ pos[0] + ~~(@size[0] / 2), pos[1] + ~~(@size[1] / 2) ]

  #$.extend DomLayer.prototype, JqueryEventsMixin
  DomLayer
