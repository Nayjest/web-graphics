// Generated by CoffeeScript 1.3.3

/*
Module DomLayer
@author Vitalii [Nayjest] Stepanenko <gmail@vitaliy.in>
*/


(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['components/graphics/lib/layers/dom/DomLayer'], function(DomLayer) {
    "use strict";

    var DomRectLayer, _defaults;
    _defaults = {
      color: 'gray',
      borderColor: 'red',
      borderWidth: 0
    };
    return DomRectLayer = (function(_super) {

      __extends(DomRectLayer, _super);

      function DomRectLayer(config) {
        if (config == null) {
          config = {};
        }
        DomRectLayer.__super__.constructor.call(this, config);
        this.setColor(config.color || _defaults.color);
        this.setBorderColor(config.borderColor || _defaults.borderColor);
        this.setBorderWidth(config.borderWidth || _defaults.borderWidth);
      }

      DomRectLayer.prototype.setColor = function(_color) {
        this._color = _color;
        return this.$el.css('background-color', this._color);
      };

      DomRectLayer.prototype.setBorderColor = function(_borderColor) {
        this._borderColor = _borderColor;
        return this.$el.css('border-color', this._borderColor);
      };

      DomRectLayer.prototype.setBorderWidth = function(_borderWidth) {
        this._borderWidth = _borderWidth;
        if (this._borderWidth) {
          this.$el.css('border-style', 'solid');
        } else {
          this.$el.css('border-style', 'none');
        }
        return this.$el.css('border-width', this._borderWidth + 'px');
      };

      return DomRectLayer;

    })(DomLayer);
  });

}).call(this);
