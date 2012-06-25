class Enemy < Sprite
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithSpriteFrameName "enemy.png"
    self.position = Point.new(200, 200)
  end

  def move
    rand_x = rand(3) - 1
    rand_y = rand(3) - 1
    rand_y = 1 if rand_y == 0 and rand_x == 0
    x = self.position.x + rand_x
    y = self.position.y + rand_y

    self.position = Point.new(x, y)
  end
end
