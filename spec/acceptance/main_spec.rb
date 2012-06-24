describe "Application 'Touchaga'" do
  before do
    CCDirector.sharedDirector.replaceScene GameLayer.scene
    CCDirector.sharedDirector.drawScene
  end

  it "can move the player by touching and dragging" do
    SpecHelper.touch SpecHelper.player.position
    SpecHelper.move_player Point.new(100, 100)
    SpecHelper.player.position.should == Point.new(100, 100)
  end

  it "player phases out when finger off screen" do
    SpecHelper.touch SpecHelper.player.position
    player_releases_sprite

    SpecHelper.player.phased_out?.should == true
    SpecHelper.player.visible?.should == false

    SpecHelper.warp_out.visible?.should == true
    SpecHelper.warp_out.position.should == SpecHelper.player.position
  end

  it "when phased out player can phase back into circle" do
    SpecHelper.touch SpecHelper.player.position
    player_releases_sprite


    position = Point.new(SpecHelper.player.position.x + 10, SpecHelper.player.position.y + 10)
    SpecHelper.touch position

    SpecHelper.player.phased_out?.should == false
    SpecHelper.player.visible?.should == true
    SpecHelper.player.position.should == position

    SpecHelper.warp_out.visible?.should == false
  end

  it "when phased out circle shrinks" do
    SpecHelper.touch SpecHelper.player.position
    player_releases_sprite

    largest_bound_position = Point.new(SpecHelper.player.position.x + 120, SpecHelper.player.position.y)
    SpecHelper.warp_out.in_phase_in_area?(largest_bound_position).should == true

    100.times { SpecHelper.next_frame }

    SpecHelper.warp_out.in_phase_in_area?(largest_bound_position).should == false
  end

  it "fires bullets while phased in" do
    SpecHelper.touch SpecHelper.player.position
    
    SpecHelper.next_frame

    SpecHelper.game_layer.bullets.size.should > 0
    SpecHelper.game_layer.bullets.first.position.should.not == SpecHelper.player.position
  end

  def player_releases_sprite
    SpecHelper.game_layer.touch_ended
  end
end
