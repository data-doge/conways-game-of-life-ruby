class Bacteria

  attr_accessor :alive, :neighbors

  def initialize(probability = 0)
    @alive = rand > probability
    @neighbors = 0
  end

end