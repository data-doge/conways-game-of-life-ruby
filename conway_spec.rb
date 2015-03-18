require_relative "./conway.rb"

describe "Conway" do

  before(:all) do
    @size = 20
    @conway = Conway.new(@size)
    @mini_conway = Conway.new(4)
    @mini_conway.grid = [
      [Bacteria.new(0), Bacteria.new(0), Bacteria.new(0), Bacteria.new(0)],
      [Bacteria.new(1), Bacteria.new(1), Bacteria.new(1), Bacteria.new(0)],
      [Bacteria.new(0), Bacteria.new(0), Bacteria.new(0), Bacteria.new(1)],
      [Bacteria.new(0), Bacteria.new(0), Bacteria.new(1), Bacteria.new(0)]
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
      it "each cell is an instance of the Bacteria class" do
        expect(@conway.grid.first.first).to be_a(Bacteria)
      end
      it "has dead and alive bacteria" do
        live_bacteria_count = @conway.grid.flatten.select { |bacteria| bacteria.alive}.uniq.length
        expect(live_bacteria_count).to be < (@size ** 2)
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
    it "returns true if bacteria at r,c is alive" do
      expect(@mini_conway.alive?(0,0)).to be_truthy
    end
    it "returns false if bacteria at r,c is dead" do
      expect(@mini_conway.alive?(1,0)).to be_falsey
    end
  end

  describe "#tally_neighbors_for!(r,c)" do
    it "bacteria at 3,2 should have 4 neighbors" do
      @mini_conway.tally_neighbors_for!(3,2)
      expect(@mini_conway.grid[3][2].neighbors).to eq(4)
    end
    it "bacteria at 0,3 should have 2 neighbors" do
      @mini_conway.tally_neighbors_for!(0,3)
      expect(@mini_conway.grid[0][3].neighbors).to eq(2)
    end
    it "bacteria at 3,0 should have 3 neighbors" do
      @mini_conway.tally_neighbors_for!(3,0)
      expect(@mini_conway.grid[3][0].neighbors).to eq(3)
    end
    it "bacteria at 0,0 should have 1 neighbor" do
      @mini_conway.tally_neighbors_for!(0,0)
      expect(@mini_conway.grid[0][0].neighbors).to eq(1)
    end
    it "bacteria at 2,3 should have 3 neighbors" do
      @mini_conway.tally_neighbors_for!(2,3)
      expect(@mini_conway.grid[2][3].neighbors).to eq(3)
    end
  end

  describe "#overpopulated?(r,c)" do
    it "returns true if bacteria at r,c has 3 or more neighbors" do
      expect(@mini_conway.overpopulated?(3,2)).to be_truthy
    end
    it "returns false if bacteria at r,c has less than 4 neighbors" do
      expect(@mini_conway.overpopulated?(0,3)).to be_falsey
    end
  end

  describe "#underpopulated?(r,c)" do
  end

  describe "#sexytime?(r,c)" do
  end

  describe "update_cell!(r,c)" do
  end

end