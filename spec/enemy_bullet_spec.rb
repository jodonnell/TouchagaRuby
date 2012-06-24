describe EnemyBullet do
  it "has a position" do
    @enemy_bullet = EnemyBullet.new Point.new(100, 100)
    @enemy_bullet.position.should == Point.new(100, 100)
  end
end
