require_relative './bacteria.rb'

class Conway

  attr_accessor :grid, :size

  def initialize(size = 20)
    @size = size
    @grid = Array.new(size) { Array.new(size) { Bacteria.new(0.95) } }
    @directions = [ [-1,-1], [-1, 0], [-1, 1], [ 0,-1], [ 0, 1], [ 1,-1], [ 1, 0], [ 1, 1] ]
  end

  def update_cell!(r,c)
    @grid[r][c].alive = false if alive?(r,c) && (overpopulated?(r,c) || underpopulated?(r,c))
    @grid[r][c].alive = true if !alive?(r,c) && sexytime?(r,c)
  end

  def alive?(r,c)
    @grid[r][c].alive
  end

  def overpopulated?(r,c)
    @grid[r][c].neighbors > 3
  end

  def underpopulated?(r,c)
    @grid[r][c].neighbors < 2
  end

  def sexytime?(r,c)
    @grid[r][c].neighbors == 3
  end

  def tally_neighbors_for!(r,c)
    @directions.each do |i,j|
      if in_bounds?(r + i, c + j) && alive?(r + i, c + j)
        @grid[r][c].neighbors += 1
      end
    end
  end

  def tally_neighbors!
    @grid.each_with_index do |row,r|
      row.each_with_index do |cell,c|
        tally_neighbors_for!(r,c)
      end
    end
  end

  def in_bounds?(r,c)
    r.between?(0,@size - 1) && c.between?(0,@size - 1)
  end

  def print
    system('clear')
    @grid.each { |row| p row.map { |cell| cell.alive ? "X" : " "} }
  end

end

conway = Conway.new(20)
puts "has correct size of 20"
puts conway.size == 20
puts "grid has correct height"
puts conway.grid.length == 20
puts "grid has correct width"
puts conway.grid.first.length == 20
puts "each cell is an instance of the Bacteria model"
puts conway.grid.first.first.class == Bacteria
puts "there are dead and alive bacteria on the grid"
puts conway.grid.flatten.select { |bacteria| bacteria.alive }.uniq.length < 400
puts "19,19 is in_bounds"
puts conway.in_bounds?(19,19)
puts "0,0 is in_bounds"
puts conway.in_bounds?(0,0)
puts "0,19 is in_bounds"
puts conway.in_bounds?(0,19)
puts "19,0 is in_bounds"
puts conway.in_bounds?(19,0)

puts "20,0 is out of bounds"
puts conway.in_bounds?(20,0) == false
puts "0,20 is out of bounds"
puts conway.in_bounds?(0,20) == false
puts "0,-1 is out of bounds"
puts conway.in_bounds?(0,-1) == false
puts "-1,0 is out of bounds"
puts conway.in_bounds?(-1,0) == false

conway.grid = [
  [Bacteria.new(0), Bacteria.new(0), Bacteria.new(0), Bacteria.new(0)],
  [Bacteria.new(1), Bacteria.new(1), Bacteria.new(1), Bacteria.new(0)],
  [Bacteria.new(0), Bacteria.new(0), Bacteria.new(0), Bacteria.new(1)],
  [Bacteria.new(0), Bacteria.new(0), Bacteria.new(1), Bacteria.new(0)]
]
conway.size = 4

# x x x x
# o o o x
# x x x o
# x x o x

puts "bacteria 0,0 is alive"
puts conway.alive?(0,0) == true
puts "bacteria 1,0 is dead"
puts conway.alive?(1,0) == false

puts "bacteria at 3,2 should have 4 neighbors"
conway.tally_neighbors_for!(3,2)
puts conway.grid[3][2].neighbors == 4
puts "bacteria at 0,3 should have 2 neighbors"
conway.tally_neighbors_for!(0,3)
puts conway.grid[0][3].neighbors == 2
puts "bacteria at 3,0 should have 3 neighbors"
conway.tally_neighbors_for!(3,0)
puts conway.grid[3][0].neighbors == 3
puts "bacteria at 0,0 should have 1 neighbor"
conway.tally_neighbors_for!(0,0)
puts conway.grid[0][0].neighbors == 1
puts "bacteria at 2,3 should have 3 neighbors"
conway.tally_neighbors_for!(2,3)
puts conway.grid[2][3].neighbors == 3

puts "bacteria at 3,2 should be overpopulated"
puts conway.overpopulated?(3,2)
puts "bacteria at 0,0 should be underpopulated"
puts conway.underpopulated?(0,0)
puts "bacteria at 2,3 should be sexytime"
puts conway.sexytime?(2,3)

puts "3,2 should be dead by overpopulation"
conway.update_cell!(3,2)
puts conway.grid[3][2].alive == false
puts "0,0 should be dead by underpopulation"
conway.update_cell!(0,0)
puts conway.grid[0][0].alive == false
puts "0,3 should be alive because 2 exactly"
conway.update_cell!(0,3)
puts conway.grid[0][3].alive
puts "3,0 should be alive because 3 exactly"
conway.update_cell!(3,0)
puts conway.grid[3][0].alive
puts "2,3 should be alive because reproduction"
conway.update_cell!(2,3)
puts conway.grid[2][3].alive