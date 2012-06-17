describe "Application 'Touchaga'" do
  before do
    CCDirector.sharedDirector.replaceScene GameLayer.scene
    CCDirector.sharedDirector.drawScene
  end

  it "can move the player by touching and dragging" do
    touch player.position
    move_player Point.new(100, 100)
    player.position.should == Point.new(100, 100)
  end

  it "player phases out when finger off screen" do
    touch player.position
    player_releases_sprite

    player.phased_out?.should == true
    player.visible?.should == false

    warp_out.visible?.should == true
    warp_out.position.should == player.position
  end

  it "when phased out player can phase back into circle" do
    touch player.position
    player_releases_sprite


    position = Point.new(player.position.x + 10, player.position.y + 10)
    touch position

    player.phased_out?.should == false
    player.visible?.should == true
    player.position.should == position

    warp_out.visible?.should == false
  end

  it "when phased out circle shrinks" do
    touch player.position
    player_releases_sprite

    largest_bound_position = Point.new(player.position.x + 120, player.position.y)
    warp_out.in_phase_in_area?(largest_bound_position).should == true

    10.times { next_frame }

    warp_out.in_phase_in_area?(largest_bound_position).should == false
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

      yield Point.new(x, y)
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

  def next_frame
    game_layer.update
  end

  def find_slope_between_points
    
  end

  def remove_touch
    
  end

  def player
    game_layer.player
  end

  def warp_out
    game_layer.warp_out
  end

  def game_layer
    CCDirector.sharedDirector.runningScene.getChildByTag(1)
  end
end
