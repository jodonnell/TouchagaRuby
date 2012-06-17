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
    touch_began location
  end

  def touch_began position
    if @player.phased_out?
      phase_in = @player.in_phase_in_area?(position)
      if phase_in
        @player.phase_in
        move_player position
      end
      phase_in
    else
      CGRectContainsPoint(@player.sprite.boundingBox, position)
    end
  end

  def ccTouchMoved(touch, withEvent:event)
    location = convertTouchToNodeSpace(touch)
    touch_moved location
  end

  def ccTouchEnded(touch, withEvent:event)
    touch_ended
  end

  def touch_moved position
    move_player position
  end

  def touch_ended
    @player.phase_out
  end

  def move_player position
    @player.sprite.position = position
  end

  def self.scene
    scene = CCScene.node
    layer = GameLayer.node
    scene.addChild layer, z:1, tag: 1
    scene
  end
end
