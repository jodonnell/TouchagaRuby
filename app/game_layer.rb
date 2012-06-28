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

  def onEnter
    super
    @frame_tick = 0

    CCSpriteFrameCache.sharedSpriteFrameCache.addSpriteFramesWithFile("sprites.plist")

    bullets_batch = CCSpriteBatchNode.batchNodeWithFile("sprites.png")
    addChild(bullets_batch, z:1, tag:0)

    @bullets = 190.times.collect do |x|
      bullet = Bullet.new
      bullet.sprite.setPosition(CGPoint.new(rand(320), rand(400)))
      bullets_batch.addChild bullet.sprite, z: 1, tag:x
      bullet
    end

    schedule 'update'
  end

  def update
    node = getChildByTag 0
    @bullets.each {|bullet|
      if bullet.position.y > 500
        bullet.sprite.setPosition(CGPoint.new(bullet.position.x, 0))
      else
        bullet.sprite.setPosition(CGPoint.new(bullet.position.x, bullet.position.y + 10))
      end
    }
  end

end
