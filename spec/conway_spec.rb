require_relative "../models/conway.rb"

describe "Conway" do

  before(:all) do
    @size = 20
    @conway = Conway.new(@size)
    @mini_conway = Conway.new(4)
    @mini_conway.grid = [
      [Cell.new(0), Cell.new(0), Cell.new(0), Cell.new(0)],
      [Cell.new(1), Cell.new(1), Cell.new(1), Cell.new(0)],
      [Cell.new(0), Cell.new(0), Cell.new(0), Cell.new(1)],
      [Cell.new(0), Cell.new(0), Cell.new(1), Cell.new(0)]
    ]
  end

  describe "#initialize(size)" do

    describe "size" do

      it "if unspecified, size assigned to 20" do
        expect(Conway.new.size).to eq(20)
      end

      it "otherwise, assigns user-specified size" do
        expect(@conway.size).to eq(@size)
      end

    end

    describe "grid" do

      it "has height equal to size" do
        expect(@conway.grid.length).to eq(@size)
      end

      it "has width equal to size" do
        expect(@conway.grid.first.length).to eq(@size)
      end

      it "each cell is an instance of the Cell class" do
        expect(@conway.grid.first.first).to be_a(Cell)
      end

      it "has dead and alive cell" do
        live_cell_count = @conway.grid.flatten.select { |cell| cell.alive}.uniq.length
        expect(live_cell_count).to be < (@size ** 2)
      end

    end

    describe "directions" do

      it "is an array of all radial steps N,E,W,S,NE,NW,SE,SW" do
        expect(@conway.directions).to match_array([[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]])
      end

    end

  end

  describe "#in_bounds?(r,c)" do

    describe "with a size of 20" do

      it "returns true for 19,19" do
        expect(@conway.in_bounds?(19,19)).to be_truthy
      end

      it "returns true for 0,0" do
        expect(@conway.in_bounds?(0,0)).to be_truthy
      end

      it "returns true for 0,19" do
        expect(@conway.in_bounds?(0,19)).to be_truthy
      end

      it "returns true for 19,0" do
        expect(@conway.in_bounds?(19,0)).to be_truthy
      end

      it "returns false for 20,0" do
        expect(@conway.in_bounds?(20,0)).to be_falsey
      end

      it "returns false for 0,20" do
        expect(@conway.in_bounds?(0,20)).to be_falsey
      end

      it "returns false for 0,-1" do
        expect(@conway.in_bounds?(0,-1)).to be_falsey
      end

      it "returns false for -1,0" do
        expect(@conway.in_bounds?(-1,0)).to be_falsey
      end

    end

  end

  describe "#alive?(r,c)" do

    it "returns true if cell at r,c is alive" do
      expect(@mini_conway.alive?(0,0)).to be_truthy
    end

    it "returns false if cell at r,c is dead" do
      expect(@mini_conway.alive?(1,0)).to be_falsey
    end

  end

  describe "#tally_neighbors_for!(r,c)" do

    it "assigns 4 neighbors to cell at 3,2" do
      @mini_conway.tally_neighbors_for!(3,2)
      expect(@mini_conway.grid[3][2].neighbors).to eq(4)
    end

    it "assigns 2 neighbors to cell at 0,3" do
      @mini_conway.tally_neighbors_for!(0,3)
      expect(@mini_conway.grid[0][3].neighbors).to eq(2)
    end

    it "assigns 3 neighbors to cell at 3,0" do
      @mini_conway.tally_neighbors_for!(3,0)
      expect(@mini_conway.grid[3][0].neighbors).to eq(3)
    end

    it "assigns 1 neighbor to cell at 0,0" do
      @mini_conway.tally_neighbors_for!(0,0)
      expect(@mini_conway.grid[0][0].neighbors).to eq(1)
    end

    it "assigns 3 neighbors to cell at 2,3" do
      @mini_conway.tally_neighbors_for!(2,3)
      expect(@mini_conway.grid[2][3].neighbors).to eq(3)
    end

    it "resets a cells number of neighbors before recalculating" do
      @mini_conway.tally_neighbors_for!(2,3)
      expect(@mini_conway.grid[2][3].neighbors).to eq(3)
    end

  end

  describe "#overpopulated?(r,c)" do

    it "returns true if cell at r,c has 3 or more neighbors" do
      expect(@mini_conway.overpopulated?(3,2)).to be_truthy
    end

    it "returns false if cell at r,c has less than 4 neighbors" do
      expect(@mini_conway.overpopulated?(0,3)).to be_falsey
    end

  end

  describe "#underpopulated?(r,c)" do

    it "returns true if cell at r,c has less than 2 neighbors" do
      expect(@mini_conway.underpopulated?(0,0)).to be_truthy
    end

    it "returns false if cell at r,c has 2 or more neighbors" do
      expect(@mini_conway.underpopulated?(3,2)).to be_falsey
    end

  end

  describe "#sexytime?(r,c)" do

    it "returns true if cell has exactly 3 neighbors" do
      expect(@mini_conway.sexytime?(2,3)).to be_truthy
    end

    it "otherwise, returns false" do
      expect(@mini_conway.sexytime?(0,0)).to be_falsey
    end

  end

  describe "#update_cell!(r,c)" do

    it "if live cell is in an overpopulated cell, cell dies" do
      @mini_conway.update_cell!(3,2)
      expect(@mini_conway.grid[3][2].alive).to be_falsey
    end

    it "if live cell is in an underpopulated cell, cell dies" do
      @mini_conway.update_cell!(0,0)
      expect(@mini_conway.grid[0][0].alive).to be_falsey
    end

    it "if dead cell is ready for sexytime, cell is resurrected" do
      @mini_conway.update_cell!(2,3)
      expect(@mini_conway.grid[2][3].alive).to be_truthy
    end

    it "if live cell is neither overpopulated or underpopulated, it lives on" do
      @mini_conway.update_cell!(2,3)
      expect(@mini_conway.grid[2][3].alive).to be_truthy
    end

  end

end