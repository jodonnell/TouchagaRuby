describe "Application 'cocomotion'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "can move the player by touching and dragging" do
    touch player.sprite.position
    move_player CGPointMake(100, 100)
    player.sprite.position.should == CGPointMake(100, 100)
  end

  it "player phases out when finger off screen" do
    touch player.sprite.position
    player_releases_sprite

    player.phased_out?.should == true
    player.sprite.visible.should == false
  end

  it "when phased out player can phase back into circle" do
    touch player.sprite.position
    player_releases_sprite

    position = player.sprite.position
    position.x += 10
    position.y += 10
    touch position

    player.phased_out?.should == false
    player.sprite.visible.should == true
    player.sprite.position.should == position
  end

  def player_releases_sprite
    game_layer.touch_ended
  end

  def move_player move_to
    drag_to(move_to) do |pos|
      game_layer.touch_moved(pos)
    end
  end

  def touch pos
    @beginTouch = pos
    game_layer.touch_began pos
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
