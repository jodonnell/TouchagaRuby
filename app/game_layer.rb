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

    @bullets_batch = CCSpriteBatchNode.batchNodeWithFile("sprites.png")
    addChild(@bullets_batch)

    @bullets = 350.times.collect do 
      bullet = CCSprite.spriteWithSpriteFrameName("bullet.png")
      bullet.setPosition(CGPoint.new(rand(320), rand(400)))
      @bullets_batch.addChild bullet
      bullet
    end

    schedule 'update'
  end

  def update
    @bullets.each {|bullet|
      if bullet.position.y > 500
        bullet.setPosition(CGPoint.new(bullet.position.x, 0))
      else
         bullet.setPosition(CGPoint.new(bullet.position.x, bullet.position.y + 10))
      end
    }
    @frame_tick += 1
  end

end
