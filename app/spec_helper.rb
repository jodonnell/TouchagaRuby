class SpecHelper

  def self.game_layer
    CCDirector.sharedDirector.runningScene.getChildByTag(1)
  end

  def self.next_frame
    game_layer.update
  end

  def self.warp_out
    game_layer.warp_out
  end

  def self.player
    game_layer.player
  end

  def self.move_player move_to
    drag_to(move_to) do |pos|
      game_layer.touch_moved(pos)
    end
  end

  def self.touch pos
    @beginTouch = pos
    game_layer.touch_began pos
  end

  def self.release_touch
    game_layer.touch_ended
  end

  def self.drag_to pos
    while pos != player.sprite.position
      position = player.sprite.position

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
