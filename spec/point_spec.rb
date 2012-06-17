describe Point do

  it "can be created with ints" do
    point = Point.new 1, 1
    point.x.should == 1
    point.y.should == 1
  end

  it "can be created with CGPoint" do
    point = Point.new CGPointMake(1, 1)
    point.x.should == 1
    point.y.should == 1
  end

  it "can return a CGPoint" do
    point = Point.new 1, 1
    point.cg.should == CGPointMake(1, 1)
  end

end
