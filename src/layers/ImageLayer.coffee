###
Use this file to load Layer class according to rendering engine specified in settings
###
"use strict"

# Get global object (window in browser) in strict mode
FN = Function
glob = FN('return this')()

# Get settings from global object
settings = glob.settings ?= {}

# default settings
settings.graphicsEngine ?= 'dom'

# module dependencies according to specific graphicEngines
dependencies =
  canvas: ['layers/canvas/CanvasImageLayer', 'layers/canvas/DrawManager']
  dom: ['layers/DomImageLayer']
  webgl: []
  'webgl-2d': ['layers/canvas/CanvasImageLayer', 'layers/canvas/DrawManager', 'layers/webgl-2d/enable']

define dependencies[settings.graphicsEngine], (ImageLayer) ->
  ImageLayer