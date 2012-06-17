class Player
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "player.png"
    size = CCDirector.sharedDirector.winSize
    @sprite.position = CGPointMake(300, 300)
    @phased_out = false
  end
  
  def phase_out
    @phased_out = true
    @sprite.visible = false
  end

  def phase_in
    @phased_out = false
    @sprite.visible = true
  end

  def phased_out?
    @phased_out
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
