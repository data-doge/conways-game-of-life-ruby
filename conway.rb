class Conway

  def initialize
    @grid = Array.new(20) { Array.new(20) { rand > 0.95 } }
  end

  def print
    @grid.each { |row| p row }
  end

end

conway = Conway.new
conway.print