require_relative "../day_09"

RSpec.describe Day09 do
  context "part 1" do
    it "works for the sample input" do
      input = <<~INPUT
        2199943210
        3987894921
        9856789892
        8767896789
        9899965678
      INPUT

      expect(Day09.part_1(input)).to eq 15
    end

    it "works for the input file" do
      input = File.read("spec/fixtures/day_09.txt")

      expect(Day09.part_1(input)).to eq 278
    end
  end

  context "part 2" do
  end
end
