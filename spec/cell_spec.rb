require_relative "../models/cell.rb"

describe "Cell" do

  describe "#initialize(probability)" do

    it "assigns neighbors to 0" do
      expect(Cell.new.neighbors).to eq(0)
    end

    it "if probability unspecified, assigns alive to true" do
      cell = Cell.new
      expect(cell.alive).to be_truthy
    end

    it "if probability is 0, assigns alive to true" do
      cell = Cell.new(0)
      expect(cell.alive).to be_truthy
    end

    it "if probability is 1, assigns alive to false" do
      cell = Cell.new(1)
      expect(cell.alive).to be_falsey
    end

  end

end