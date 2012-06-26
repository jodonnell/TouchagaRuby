describe Player do
  before do
    @player = Player.new
  end

  it "can move" do
    @player.move_to Point.new(100, 100)
    @player.position.should == Point.new(100, 100)
  end

  it "can phase in and out" do
    @player.phased_out?.should == false

    @player.phase_out
    @player.phased_out?.should == true
    @player.visible?.should == false

    @player.phase_in
    @player.phased_out?.should == false
    @player.visible?.should == true
  end

  it "can create a new life" do
    @player.dead = true
    @player.phase_out
    @player.dead = false
    @player.phased_out?.should == false
  end
end
