describe "Enemy" do
  before do
    CCDirector.sharedDirector.replaceScene GameLayer.scene
    CCDirector.sharedDirector.drawScene
  end

  it "can follow a path" do
    SpecHelper.game_layer.create_enemy Point.new(0, 100), Path.new(Array.new(10, [1,-1]))
    10.times { SpecHelper.next_frame }
    SpecHelper.game_layer.enemies.first.position.should == Point.new(10, 90)
  end

  it "can crash into player" do
    SpecHelper.game_layer.create_enemy Point.new(100, 100), Path.new([1, 1])
    SpecHelper.touch SpecHelper.player.position
    SpecHelper.move_player Point.new(100, 100)
    SpecHelper.next_frame
    SpecHelper.player.dead?.should == true
  end

  it "can not crash into player when phased out" do
    SpecHelper.game_layer.create_enemy Point.new(100, 100), Path.new([1, 1])
    SpecHelper.touch SpecHelper.player.position
    SpecHelper.move_player Point.new(100, 100)
    SpecHelper.release_touch
    SpecHelper.next_frame
    SpecHelper.player.dead?.should == false
  end

  it "can shoot bullets" do
    SpecHelper.game_layer.create_enemy Point.new(100, 100), Path.new([1, 1])
    SpecHelper.next_frame
    SpecHelper.game_layer.enemy_bullets.first.position.y.should >= 89
    SpecHelper.game_layer.enemy_bullets.first.position.y.should <= 91
  end

end
