describe Bullet do
  before do
    @bullet = Bullet.new(Point.new(100, 100))
  end

  it "has a position" do
    @bullet.position.should == Point.new(100, 100)
  end
end
