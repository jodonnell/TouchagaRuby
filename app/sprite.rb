class Sprite
  def move_to point
    @sprite.position = point.cg
  end

  def position
    Point.new(@sprite.position)
  end

  def position= position
    @sprite.position = position.cg
  end

  def visible?
    @sprite.visible
  end
end