class Bullet < Sprite
  attr_accessor :sprite

  def initialize point
    @sprite = CCSprite.spriteWithFile "bullet.png"
    self.position = point
  end

  def move
    self.position = Point.new(position.x, position.y + 5)
  end

  def off_screen?
    position.y > CCDirector.sharedDirector.winSize.height + 15
  end
end
