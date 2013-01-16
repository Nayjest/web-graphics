###
Use this file to load Layer class according to rendering engine specified in settings
###
"use strict"
FN = Function
glob = FN("return this")()
settings = glob.settings = if glob.settings then glob.settings else {}
settings.graphicsEngine = "dom"  unless settings.graphicsEngine
dependencies =
  canvas: [ "layers/NonDomLayer" ]
  dom: [ "lib.nayjest/graphics/layers/dom/DomLayer" ]
  webgl: []
  "webgl-2d": [ "layers/NonDomLayer" ]

define dependencies[settings.graphicsEngine], (Layer) ->
  Layer