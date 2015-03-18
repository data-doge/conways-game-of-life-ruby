require_relative './bacteria.rb'

class Conway

  attr_accessor :grid, :size, :directions

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
