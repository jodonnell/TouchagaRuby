class EnemyBullet < Sprite
  attr_accessor :sprite

  def initialize point, batch = nil
    @sprite = CCSprite.spriteWithTexture(batch.texture) if batch
    @sprite = CCSprite.spriteWithFile "bullet.png" unless batch

    self.position = point
  end

  def move
    self.position = Point.new(position.x, position.y - 10)
  end

  def off_screen?
    position.y < 0
  end

end