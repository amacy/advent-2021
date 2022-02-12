require_relative "../day_05"

RSpec.describe Day05 do
  context "part 1" do
    it "works for the sample input" do
      input = <<~INPUT
        0,9 -> 5,9
        8,0 -> 0,8
        9,4 -> 3,4
        2,2 -> 2,1
        7,0 -> 7,4
        6,4 -> 2,0
        0,9 -> 2,9
        3,4 -> 1,4
        0,0 -> 8,8
        5,5 -> 8,2
      INPUT

      expect(Day05.part_1(input)).to eq 5
    end

    it "works for the input file" do
      input = File.read("spec/fixtures/day_05.txt")

      expect(Day05.part_1(input)).to eq 6189
    end
  end

  context "part 2" do
  end
end
