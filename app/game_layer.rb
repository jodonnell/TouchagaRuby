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
    @frame_tick = 0

    @player = Player.new
    addChild @player.sprite

    @warp_out = WarpOutCircle.new @player.position
    addChild @warp_out.sprite

    @bulletsBatch = CCSpriteBatchNode.batchNodeWithFile("bullet.png")
    addChild(@bulletsBatch)

    @bullets = 100.times.collect do 
      bullet = Bullet.new @bulletsBatch
      @bulletsBatch.addChild bullet.sprite
      bullet
    end

    self.isTouchEnabled = true
    schedule 'update'
  end

  def update
    if @player.phased_out?
      @warp_out.energy_percentage -= 0.001
      @warp_out.energy_percentage = 0 if @warp_out.energy_percentage < 0
    else
      fire_bullet
    end

    move_bullets
    
    remove_offscreen_bullets

    @frame_tick += 1

    @frame_tick = 0 if @frame_tick == 1000
  end

  def fire_bullet
    inactive_bullets = @bullets.select {|bullet| bullet.visible? == false}
    inactive_bullet = inactive_bullets.first
    inactive_bullet.move_to @player.position
    inactive_bullet.sprite.visible = true
  end

  def move_bullets
    @bullets.each { |bullet| bullet.move if bullet.visible? }
  end

  def remove_offscreen_bullets
    @bullets.each do |bullet| 
      bullet.sprite.visible = false if bullet.off_screen?
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
