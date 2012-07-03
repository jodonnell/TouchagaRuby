class Sprite
  def move_to point
    @sprite.position = point
  end

  def position
    @sprite.position
  end

  def position= position
    @sprite.position = position
  end

  def visible?
    @sprite.visible
  end

  def visible= visible
    @sprite.visible = visible
  end

  def remove
    @sprite.removeFromParentAndCleanup(true)
  end

  def dead?
    @dead
  end

  def dead= dead
    @dead = dead
  end

end
