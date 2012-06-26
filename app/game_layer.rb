class GameLayer < CCLayer 
  attr_accessor :player
  attr_accessor :warp_out
  attr_accessor :level

  attr_reader :bullets
  attr_reader :enemies
  attr_reader :enemy_bullets

  def self.scene
    scene = CCScene.node
    layer = GameLayer.node

    scene.addChild layer, z:1, tag: 1
    scene
  end

  def self.scene_with_test_level
    scene = GameLayer.scene
    layer = scene.getChildByTag(1)
    level = TestLevel.new layer
    layer.level = level
    scene
  end

  def onEnter
    super
    @frame_tick = 0

    CCSpriteFrameCache.sharedSpriteFrameCache.addSpriteFramesWithFile("sprites.plist")

    @bullets_batch = CCSpriteBatchNode.batchNodeWithFile("sprites.png")
    addChild(@bullets_batch)

    @bullets = 1000.times.collect do 
      bullet = CCSprite.spriteWithSpriteFrameName("bullet.png")
      bullet.setPosition(CGPoint.new(rand(320), rand(400)))
      @bullets_batch.addChild bullet
      move_action = CCMoveTo.actionWithDuration( rand(4), position:CGPoint.new(bullet.position.x, 550))
      bullet.runAction move_action
      bullet
    end

    # @player = Player.new
    # @player.dead = true
    # @bullets_batch.addChild @player.sprite

    # @warp_out = WarpOutCircle.new @player.position
    # @bullets_batch.addChild @warp_out.sprite

#    create_bullets

    # @enemies = []

    #self.isTouchEnabled = true
    schedule 'update'
  end

  def create_bullets
    @bullets = 250.times.collect do 
      bullet = Bullet.new
      @bullets_batch.addChild bullet.sprite

      bullet
    end

    # @enemy_bullets = 100.times.collect do 
    #   bullet = EnemyBullet.new
    #   @bullets_batch.addChild bullet.sprite
    #   bullet
    # end
  end

  def update
    # if @player.phased_out?
    #   @warp_out.energy_percentage -= 0.001
    #   @warp_out.energy_percentage = 0 if @warp_out.energy_percentage < 0
    # elsif !@player.dead?
    #   fire_bullet @bullets, @player.position if @frame_tick % 4 == 0
    # end

    # @level.update @frame_tick

    #move_bullets @bullets
    @bullets.each {|bullet|
      if bullet.position.y > 500
        bullet.setPosition(CGPoint.new(bullet.position.x, 0))
	bullet.stopAllActions
        move_action = CCMoveTo.actionWithDuration( rand(4), position:CGPoint.new(bullet.position.x, 550))
        bullet.runAction move_action
        
      else
        # bullet.setPosition(CGPoint.new(bullet.position.x, bullet.position.y + 10))
      end
    }


    # remove_offscreen_bullets @bullets

    # move_enemies

    # enemies_shoot if @frame_tick % 8 == 0
    # move_bullets @enemy_bullets
    # remove_offscreen_bullets @enemy_bullets

    # if player_collides?
    #   create_explosion_particle @player.position
    #   @player.dead = true
    # end

    # check_for_enemies_destroyed

    # remove_offscreen_enemies

    @frame_tick += 1
    # @frame_tick = 0 if @frame_tick == 1000000
  end

  def remove_offscreen_enemies
    @enemies.select! do |enemy| 
      remove_enemy(enemy) if enemy.dead?
      !enemy.dead?
    end
  end

  def check_for_enemies_destroyed
    return false if @enemies.size == 0
    @bullets.each do |bullet| 
      next if bullet.visible? == false
      @enemies.select! do |enemy|
        collides = CGRectIntersectsRect(enemy.sprite.boundingBox, bullet.sprite.boundingBox)
        destroy_enemy(enemy) if collides
        !collides
      end
    end
  end

  def destroy_enemy enemy
    remove_enemy enemy
    @warp_out.add_energy 0.06
    create_explosion_particle enemy.position
  end

  def create_explosion_particle point
    particle = CCParticleExplosion.node
    particle.position = point.cg
    particle.totalParticles = 250
    particle.life = 0.623
    particle.lifeVar = 0.379
    addChild particle

  end

  def remove_enemy enemy
    @bullets_batch.removeChild enemy.sprite, cleanup: true
  end

  def player_collides?
    return false if @player.phased_out? || @player.dead?
    any_collisions = false
    @enemies.each do |enemy| 
      any_collisions = true if CGRectIntersectsRect(@player.sprite.boundingBox, enemy.sprite.boundingBox)
    end

    @enemy_bullets.each do |enemy_bullet|
      next if enemy_bullet.visible? == false
      any_collisions = true if CGRectIntersectsRect(@player.sprite.boundingBox, enemy_bullet.sprite.boundingBox)
    end
    any_collisions
  end

  def fire_bullet bullets, position
    inactive_bullets = bullets.select {|bullet| bullet.visible? == false}
    inactive_bullet = inactive_bullets.first
    raise "No inactive bullets" if inactive_bullet.nil?
    inactive_bullet.move_to position
    inactive_bullet.sprite.visible = true
  end

  def move_bullets bullets
    bullets.each { |bullet| bullet.move if bullet.visible? }
  end

  def move_enemies
    @enemies.each { |enemy| enemy.move }
  end

  def enemies_shoot
    @enemies.each { |enemy| fire_bullet @enemy_bullets, enemy.position }
  end

  def create_enemies
    create_enemy Point.new(0, 400), Path.new(Array.new(340, [1, -1]))
    create_enemy Point.new(300, 400), Path.new(Array.new(340, [-1, -1]))
  end

  def create_enemy point, path
    enemy = Enemy.new path
    enemy.move_to point
    @bullets_batch.addChild enemy.sprite
    @enemies << enemy
  end

  def remove_offscreen_bullets bullets
    bullets.each do |bullet| 
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
    if @player.phased_out? && @warp_out.in_phase_in_area?(position)
      @warp_out.phase_in
      @player.phase_in
      move_player position
      return true
    elsif @player.dead?
      @player.dead = false
      touch_moved position
      return true
    end
    false
  end

  def touch_moved position
    return if @player.dead?
    move_player position
  end

  def touch_ended
    return if @player.dead?
    players_pos = @player.position
    @warp_out.position = players_pos
    @player.phase_out
    @warp_out.phase_out
  end

  def move_player position
    @player.position = position
  end

  def active_bullets
    @bullets.select { |bullet| bullet.visible? }
  end
end
