class GameLayer < CCLayer 
  attr_accessor :player
  attr_accessor :warp_out
  attr_reader :bullets

  def self.scene
    scene = CCScene.node
    layer = GameLayer.node

    scene.addChild layer, z:1, tag: 1
    scene
  end

  def onEnter
    super
    @player = Player.new
    addChild @player.sprite

    @warp_out = WarpOutCircle.new @player.position
    addChild @warp_out.sprite

    @bullets = []

    self.isTouchEnabled = true
    schedule 'update'

  end

  def update
    if @player.phased_out?
      @warp_out.energy_percentage -= 0.001
      @warp_out.energy_percentage = 0 if @warp_out.energy_percentage < 0
    else
      @bullets << Bullet.new(@player.position)
    end
  end

  def registerWithTouchDispatcher
    CCTouchDispatcher.sharedDispatcher.addTargetedDelegate(self, priority:0, swallowsTouches:true)
  end

  def ccTouchBegan(touch, withEvent:event)
    location = convertTouchToNodeSpace(touch)
    touch_began Point.new(location)
  end

  def ccTouchMoved(touch, withEvent:event)
    location = convertTouchToNodeSpace(touch)
    touch_moved Point.new(location)
  end

  def ccTouchEnded(touch, withEvent:event)
    touch_ended
  end

  def touch_began position
    if @player.phased_out?
      phase_in = @warp_out.in_phase_in_area?(position)
      if phase_in
        @warp_out.phase_in
        @player.phase_in
        move_player position
      end
      phase_in
    else
      CGRectContainsPoint(@player.sprite.boundingBox, position.cg)
    end
  end

  def touch_moved position
    move_player position
  end

  def touch_ended
    players_pos = @player.position
    @warp_out.position = players_pos
    @player.phase_out
    @warp_out.phase_out
  end

  def move_player position
    @player.position = position
  end
end
