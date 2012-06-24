describe "Enemy" do
  before do
    CCDirector.sharedDirector.replaceScene GameLayer.scene
    CCDirector.sharedDirector.drawScene
  end

  it "can move" do
    SpecHelper.game_layer.create_enemy Point.new(100, 100)
    SpecHelper.next_frame
    SpecHelper.game_layer.enemies.first.position.should.not == Point.new(100, 100)
  end

  it "can crash into player" do
    SpecHelper.game_layer.create_enemy Point.new(100, 100)
    SpecHelper.touch SpecHelper.player.position
    SpecHelper.move_player Point.new(100, 100)
    SpecHelper.next_frame
    SpecHelper.player.dead?.should == true
  end

  it "can shoot bullets" do
    SpecHelper.game_layer.create_enemy Point.new(100, 100)
    SpecHelper.next_frame
    SpecHelper.game_layer.enemy_bullets.first.position.y.should >= 89
    SpecHelper.game_layer.enemy_bullets.first.position.y.should <= 91
  end

end
