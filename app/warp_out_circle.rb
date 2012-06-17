class WarpOutCircle
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "warpCircle.png"
    @sprite.position = CGPointMake(300, 300)
    @sprite.visible = false
  end
  
  def phase_out
    @sprite.visible = true
  end

  def phase_in
    @sprite.visible = false
  end

  def in_phase_in_area? touched_point
    diameter = 50 #spriteManager.imageRect.size.width * [self convertEnergyToScaleFactor]
    radius = diameter / 2
    lefCoordOfCircle = @sprite.position.x - radius
    topCoordOfCircle = @sprite.position.y - radius
    xInBounds = (touched_point.x > lefCoordOfCircle) && (touched_point.x < lefCoordOfCircle + diameter)
    yInBounds =  (touched_point.y > topCoordOfCircle) && (touched_point.y < topCoordOfCircle + diameter)

    xDistance = (@sprite.position.x - touched_point.x).abs
    yDistance = (@sprite.position.y - touched_point.y).abs

    lineLength = Math.sqrt((xDistance ** 2) + (yDistance ** 2))

    if (xInBounds && yInBounds && (lineLength <= radius))
      true
    else
      false
    end
    

  end
end
