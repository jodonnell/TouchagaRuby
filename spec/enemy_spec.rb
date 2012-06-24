describe Enemy do
  before do
    @enemy = Enemy.new
  end

  it "can move" do
    @enemy.move_to Point.new(100, 100)
    @enemy.position.should == Point.new(100, 100)
  end

  it "can move on its own" do
    @enemy.move_to Point.new(100, 100)
    @enemy.move
    @enemy.position.should.not == Point.new(100, 100)
  end
end
