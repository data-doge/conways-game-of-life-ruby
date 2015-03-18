require_relative "./conway.rb"

describe "Conway" do

  before(:all) { @conway = Conway.new(20) }

  describe "#initialize(size)" do
    it "assigns user-specified size" do
      expect(@conway.size).to eq(20)
    end
    describe "grid" do
      it "has height equal to size" do
        expect(@conway.grid.length).to eq(20)
      end
      it "has width equal to size" do
        expect(@conway.grid.first.length).to eq(20)
      end
      it "each cell is an instance of the Bacteria class" do
        expect(@conway.grid.first.first).to be_a(Bacteria)
      end
    end
  end

  describe "#in_bounds?(r,c)" do
  end

  describe "#tally_neighbors_for!(r,c)" do
  end

  describe "#overpopulated?(r,c)" do
  end

  describe "#underpopulated?(r,c)" do
  end

  describe "#sexytime?(r,c)" do
  end

  describe "update_cell!(r,c)" do
  end

end