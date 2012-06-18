class Bullet < Sprite
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "bullet.png"
    self.position = Point.new(1, 1)
    @sprite.visible = false
  end

  def move
    self.position = Point.new(position.x, position.y + 5)
  end

  def off_screen?
    position.y > CCDirector.sharedDirector.winSize.height + 15
  end
end
