class TestLevel
  def initialize delagate
    @delagate = delagate
  end

  def update time
    @delagate.create_enemies if time == 0
    @delagate.create_enemies if time % 120 == 0

    @delagate.create_enemy Point.new(0, 400), Path.new(Array.new(340, [1, 0])) if time % 160 == 0
    @delagate.create_enemy Point.new(300, 400), Path.new(Array.new(340, [-1, 0])) if time % 160 == 0
  end
  
end
