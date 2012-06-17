describe WarpOutCircle do
  before do
    @warp_out = WarpOutCircle.new Point.new(100, 100)
  end

  it "can phase in and out" do
    @warp_out.visible?.should == false

    @warp_out.phase_out
    @warp_out.visible?.should == true

    @warp_out.phase_in
    @warp_out.visible?.should == false
  end

  it "can tell if a point is within the phase in area" do
    @warp_out.in_phase_in_area?(Point.new(149, 100)).should == true
    @warp_out.in_phase_in_area?(Point.new(150, 100)).should == false

    @warp_out.in_phase_in_area?(Point.new(65, 65)).should == true
    @warp_out.in_phase_in_area?(Point.new(64, 65)).should == false
  end

end
