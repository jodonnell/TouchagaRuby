class SpecHelper

  def self.game_layer
    CCDirector.sharedDirector.runningScene.getChildByTag(1)
  end

  def self.next_frame
    game_layer.update
  end

  def self.warp_out
    SpecHelper.game_layer.warp_out
  end

  def self.player
    SpecHelper.game_layer.player
  end

  def self.touch pos
    @beginTouch = pos
    SpecHelper.game_layer.touch_began pos
  end

  def self.drag_to pos
    while pos != SpecHelper.player.sprite.position
      position = SpecHelper.player.sprite.position

      x = closer_point position.x, pos.x
      y = closer_point position.y, pos.y

      yield Point.new(x, y)
    end
  end

  def self.closer_point start, to
    if start > to
      start - 1
    elsif start == to
      start
    else
      start + 1
    end
  end
end
