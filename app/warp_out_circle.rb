class WarpOutCircle
  attr_accessor :sprite

  def initialize point
    @sprite = CCSprite.spriteWithFile "warpCircle.png"
    @sprite.position = point.cg
    @sprite.visible = false
  end
  
  def phase_out
    @sprite.visible = true
  end

  def phase_in
    @sprite.visible = false
  end

  def in_phase_in_area? touched_point
    diameter = @sprite.boundingBox.size.width # * 1000 / 300 # [self convertEnergyToScaleFactor]
    radius = diameter / 2
    lefCoordOfCircle = position.x - radius
    topCoordOfCircle = position.y - radius
    xInBounds = (touched_point.x > lefCoordOfCircle) && (touched_point.x < lefCoordOfCircle + diameter)
    yInBounds =  (touched_point.y > topCoordOfCircle) && (touched_point.y < topCoordOfCircle + diameter)

    xDistance = (position.x - touched_point.x).abs
    yDistance = (position.y - touched_point.y).abs

    lineLength = Math.sqrt((xDistance ** 2) + (yDistance ** 2))

    if (xInBounds && yInBounds && (lineLength <= radius))
      true
    else
      false
    end
  end

  def position
    Point.new(@sprite.position)
  end

  def position= position
    @sprite.position = position.cg
  end

  def visible?
    @sprite.visible
  end
end
