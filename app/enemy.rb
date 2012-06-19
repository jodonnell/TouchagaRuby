class Enemy < Sprite
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "enemy.png"
    self.position = Point.new(200, 200)
  end

  def move
    self.position = Point.new(self.position.x + rand(3) - 1, self.position.y + rand(3) - 1)
  end
end
