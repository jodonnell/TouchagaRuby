class Player < Sprite
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "player.png"
    self.position = Point.new(200, 200)
    @phased_out = false
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
end
