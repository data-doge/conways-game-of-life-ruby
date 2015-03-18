require_relative "./conway.rb"

describe "Conway" do

  before(:all) do
    @size = 20
    @conway = Conway.new(@size)
  end

  describe "#initialize(size)" do
    it "assigns user-specified size" do
      expect(@conway.size).to eq(@size)
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