require_relative "../day_03"

RSpec.describe Day03 do
  context "part 1" do
    it "works for the sample input" do
      input = <<~INPUT
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
      INPUT

      expect(Day03.part_1(input)).to eq 198
    end

    it "works for the input file" do
      input = File.read("spec/fixtures/day_03.txt")

      expect(Day03.part_1(input)).to eq 2498354
    end
  end

  context "part 2" do
    it "works for the sample input" do
      input = <<~INPUT
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
      INPUT

      expect(Day03.part_2(input)).to eq 230
    end

    it "works for the input file" do
      input = File.read("spec/fixtures/day_03.txt")

      expect(Day03.part_2(input)).to eq 3277956
    end
  end
end
