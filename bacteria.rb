class Bacteria

  attr_accessor :alive, :neighbors

  def initialize(probability = 0)
    @alive = rand > probability
    @neighbors = 0
  end

end

bacteria = Bacteria.new
puts "bacteria is by default alive"
puts bacteria.alive == true
puts "bacteria has zero neighbors"
puts bacteria.neighbors == 0

bacteria = Bacteria.new(1)
puts "bacteria with probability 1 is not alive"
puts bacteria.alive == false
puts "..and still has 0 neighbors"
puts bacteria.neighbors == 0