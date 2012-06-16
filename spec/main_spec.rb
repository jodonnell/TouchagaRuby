describe "Application 'cocomotion'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "can move the player by touching and dragging" do
    player_touches_sprite
    player_drags_sprite
    sprites_position_moves
  end

  def player_touches_sprite
    player = game_layer.player
    touch player.sprite.position
  end

  def player_drags_sprite
    move_player CGPointMake(100, 100)
    remove_touch
  end

  def move_player move_to
    drag_to(move_to) do |pos|
      game_layer.movePlayer(pos)
    end
  end

  def sprites_position_moves
    player = game_layer.player
    player.sprite.position.should == CGPointMake(100, 100)
  end

  def touch pos
    @beginTouch = pos
  end

  def drag_to pos
    while pos != player.sprite.position
      position = player.sprite.position

      x = closer_point position.x, pos.x
      y = closer_point position.y, pos.y

      yield CGPointMake(x, y)
    end
  end

  def closer_point start, to
    if start > to
      start - 1
    elsif start == to
      start
    else
      start + 1
    end
  end

  def find_slope_between_points
    
  end

  def remove_touch
    
  end

  def player
    game_layer.player
  end

  def game_layer
    CCDirector.sharedDirector.runningScene.getChildByTag(1)
  end
end
