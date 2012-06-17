describe Bullet do
  before do
    @bullet = Bullet.new(Point.new(100, 100))
  end

  it "has a position" do
    @bullet.position.should == Point.new(100, 100)
  end

  it "can move" do
    @bullet.move
    @bullet.position.y.should > 100 
  end

  it "can tell when it is off screen" do
    height = CCDirector.sharedDirector.winSize.height
    bullet = Bullet.new(Point.new(100, height + 20))
    bullet.off_screen?.should == true
  end
end
