###
Module DomLayer
@author Vitalii [Nayjest] Stepanenko <gmail@vitaliy.in>
###
define [
  'components/graphics/lib/layers/dom/AbstractDomLayer',
  'components/graphics/lib/layers/Viewport',
], (
  AbstractDomLayer,
  Viewport
  # JqueryEventsMixin
) ->
  class DomLayer extends AbstractDomLayer
    viewportClass: Viewport

    ###
    @option config {Object|null} css DOM Element css
    @option config {Object|null} attr DOM Element attributes
    @option config {Object|null} $el DOM Element wrapped to jQuery object
    @option config {DomElement|jQuery|selector|null} domContainer
    ###
    constructor: (config)->
      super config