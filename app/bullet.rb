class Bullet < Sprite
  attr_accessor :sprite

  def initialize point
    @sprite = CCSprite.spriteWithFile "bullet.png"
    self.position = point
  end
end
