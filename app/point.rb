class Point
  def initialize x, y = nil
    if y
      @point = CGPointMake(x, y)
    else
      @point = x
    end
  end

  def x
    @point.x
  end

  def y
    @point.y
  end

  def cg
    @point
  end

  def ==(object)
    object.x == x && object.y == y
  end

end
