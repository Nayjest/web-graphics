define ['components/graphics/figures/AbstractCollisionChecker', 'components/Vector2D/Vector2D', 'components/geometry/lib/Rectangle'], (AbstractCollisionChecker, Vector2D, Rectange)->

  class RectangleCollisionChecker extends AbstractCollisionChecker
    #@todo consider angle and zoom
    isPointInside: (point)->
      Rectange.isPointInside point, @layer.pos, @layer.size, @layer.angleRad

