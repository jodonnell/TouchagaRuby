class Bullet < Sprite
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithSpriteFrameName "bullet.png"
  end
end
