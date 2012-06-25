describe Path do
  before do
    @path = Path.new([[1,1], [2,2]])
  end

  it "can get next vector" do
    @path.next_vector.should == [1,1]
    @path.next_vector.should == [2,2]
  end

  it "can tell when its on the last one" do
    @path.next_vector
    @path.next_vector
    @path.path_over?.should == true
  end
end
