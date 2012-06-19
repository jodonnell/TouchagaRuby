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

end
