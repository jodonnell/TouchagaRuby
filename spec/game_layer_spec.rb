describe GameLayer do
  before do
    @game_layer = GameLayer.node
    @game_layer.onEnter
  end

  it "can not use more than 100% energy" do
    @game_layer.warp_out.energy_percentage = 0
    @game_layer.player.phase_out
    @game_layer.update
    @game_layer.warp_out.energy_percentage.should == 0
  end

  it "destroys bullets when they go off screen" do
    @game_layer.player.phase_in
    @game_layer.update
    @game_layer.player.phase_out
    active_bullets.size.should == 1

    400.times { @game_layer.update }

    active_bullets.size.should == 0
  end

  it "can collide with enemies" do
    @game_layer.create_enemy @game_layer.player.position
    @game_layer.player_collides?.should == true
  end

  def active_bullets
    @game_layer.bullets.select {|bullet| bullet.visible?}
  end

end
