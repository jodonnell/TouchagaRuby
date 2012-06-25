class Path
  def initialize path
    @path = path
    @index = 0
  end

  def next_vector
    vector = @path[@index]
    @index += 1
    vector
  end

  def path_over?
    @index == @path.length
  end
end
