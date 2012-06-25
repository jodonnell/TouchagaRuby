class Enemy < Sprite
  attr_accessor :sprite

  def initialize path
    @sprite = CCSprite.spriteWithSpriteFrameName "enemy.png"
    self.position = Point.new(200, 200)
    @path = path
    @dead = false
  end

  def move
    vector = @path.next_vector
    self.position = Point.new(position.x + vector[0], position.y + vector[1])
    @dead = true if @path.path_over?
  end
end
