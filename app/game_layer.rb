class GameLayer < CCLayer 
  attr_accessor :player

  def onEnter
    super
    @player = Player.new
    addChild @player.sprite

    self.isTouchEnabled = true
  end

  def registerWithTouchDispatcher
    CCTouchDispatcher.sharedDispatcher.addTargetedDelegate(self, priority:0, swallowsTouches:true)
  end

  def ccTouchBegan(touch, withEvent:event)
    location = convertTouchToNodeSpace(touch)
    CGRectContainsPoint(@player.sprite.boundingBox, location)
  end

  def ccTouchMoved(touch, withEvent:event)
    location = convertTouchToNodeSpace(touch)
    movePlayer location
  end

  def movePlayer position
    @player.sprite.position = position
  end

  def self.scene
    scene = CCScene.node
    layer = GameLayer.node
    scene.addChild layer, z:1, tag: 1
    scene
  end
end
