class Bullet < Sprite
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithSpriteFrameName "bullet.png"

    self.position = Point.new(rand(300), rand(400))
  end

  def move
    #self.sprite.position = new_pos
    #CGPoint.new(self.sprite.position.x, self.sprite.position.y)

    #self.sprite.position.y = self.sprite.position.y + 10
    #Point.new(position.x, position.y + 10)
    self.position = Point.new(position.x, position.y + 3)
  end

  def off_screen?
    position.y > CCDirector.sharedDirector.winSize.height + 15
  end
end
