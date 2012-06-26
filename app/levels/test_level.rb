class TestLevel
  def initialize delagate
    @delagate = delagate
  end

  def update time
    @delagate.create_enemies if time == 0
    @delagate.create_enemies if time % 120 == 0
  end
  
end
