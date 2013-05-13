define ['components/graphics/lib/figures/AbstractFigure', 'components/Vector2D/Vector2D', 'components/geometry/lib/Rectangle'], (AbstractFigure, Vector2D, Rectangle)->

  class RectangleFigure extends AbstractFigure
    #@todo consider angle and zoom
    isPointInside: (point)->
      Rectangle.isPointInside point, @layer.getAbsolutePos(), @layer.size, @layer.angleRad

