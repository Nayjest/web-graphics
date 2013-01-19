// Generated by CoffeeScript 1.3.3

/*
Use this file to load Layer class according to rendering engine specified in settings
*/


(function() {
  "use strict";

  var FN, dependencies, glob, settings, _ref, _ref1;

  FN = Function;

  glob = FN('return this')();

  settings = (_ref = glob.settings) != null ? _ref : glob.settings = {};

  if ((_ref1 = settings.graphicsEngine) == null) {
    settings.graphicsEngine = 'dom';
  }

  dependencies = {
    canvas: ['layers/canvas/CanvasImageLayer', 'layers/canvas/DrawManager'],
    dom: ['layers/DomImageLayer'],
    webgl: [],
    'webgl-2d': ['layers/canvas/CanvasImageLayer', 'layers/canvas/DrawManager', 'layers/webgl-2d/enable']
  };

  define(dependencies[settings.graphicsEngine], function(ImageLayer) {
    return ImageLayer;
  });

}).call(this);