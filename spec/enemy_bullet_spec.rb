describe EnemyBullet do
  it "can be offscreen" do
    @enemy_bullet = EnemyBullet.new
    @enemy_bullet.move_to Point.new(20, -20)
    @enemy_bullet.off_screen?.should == true
  end
end
