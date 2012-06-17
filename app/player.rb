class Player
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "player.png"
    size = CCDirector.sharedDirector.winSize
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

  def move_to point
    @sprite.position = point.cg
  end

  def position
    Point.new(@sprite.position)
  end

  def position= position
    @sprite.position = position.cg
  end

  def visible?
    @sprite.visible
  end

end
