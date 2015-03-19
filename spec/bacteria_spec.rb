require_relative "../models/bacteria.rb"

describe "Bacteria" do

  describe "#initialize(probability)" do

    it "assigns neighbors to 0" do
      expect(Bacteria.new.neighbors).to eq(0)
    end

    it "if probability unspecified, assigns alive to true" do
      bacteria = Bacteria.new
      expect(bacteria.alive).to be_truthy
    end

    it "if probability is 0, assigns alive to true" do
      bacteria = Bacteria.new(0)
      expect(bacteria.alive).to be_truthy
    end

    it "if probability is 1, assigns alive to false" do
      bacteria = Bacteria.new(1)
      expect(bacteria.alive).to be_falsey
    end

  end

end