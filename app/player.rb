class Player < Sprite
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithSpriteFrameName "player.png"
    self.position = Point.new(200, 200)
    @phased_out = false
    self.dead = false
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

  def dead= dead
    phase_in if !dead

    @dead = dead
    @sprite.visible = !dead
  end
end
