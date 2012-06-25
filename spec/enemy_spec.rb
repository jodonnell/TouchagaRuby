describe Enemy do
  before do
    @enemy = Enemy.new Path.new([[1, 1], [2, 2]])
    @enemy.move_to Point.new(100, 100)
  end

  it "can move" do
    @enemy.position.should == Point.new(100, 100)
  end

  it "can follow its path" do
    @enemy.move
    @enemy.position.should == Point.new(101, 101)

    @enemy.move
    @enemy.position.should == Point.new(103, 103)
  end

  it "is marked dead if path over" do
    @enemy.move
    @enemy.move
    @enemy.dead?.should == true
  end
end
