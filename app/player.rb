class Player
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "player.png"
    size = CCDirector.sharedDirector.winSize
    @sprite.position = CGPointMake(300, 300)
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
