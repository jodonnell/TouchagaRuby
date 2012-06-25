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
    @game_layer.create_enemy @game_layer.player.position, Path.new([[1, 1]])
    @game_layer.player_collides?.should == true
  end

  it "can destroy an enemy with a bullet" do
    @game_layer.move_player Point.new(100, 100)
    @game_layer.fire_bullet @game_layer.bullets, @game_layer.player.position
    @game_layer.create_enemy Point.new(100,110), Path.new([[1, 1]])
    @game_layer.move_bullets @game_layer.bullets
    @game_layer.check_for_enemies_destroyed
    @game_layer.enemies.size.should == 0
  end

  it "can remove offscreen enemies" do
    @game_layer.create_enemy Point.new(0,0), Path.new([[1, 1]])
    @game_layer.move_enemies
    @game_layer.remove_offscreen_enemies
    @game_layer.enemies.size.should == 0
  end

  def active_bullets
    @game_layer.bullets.select {|bullet| bullet.visible?}
  end

end
