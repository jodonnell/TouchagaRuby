class Player
  attr_accessor :sprite

  def initialize
    @sprite = CCSprite.spriteWithFile "grossinis_sister1.png"
    size = CCDirector.sharedDirector.winSize
    @sprite.position = CGPointMake(300, 300)
  end
  
end
