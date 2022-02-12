require_relative "../day_06"

RSpec.describe Day06 do
  context "part 1" do
    it "works for the sample input" do
      input = "3,4,3,1,2"

      expect(Day06.part_1(input)).to eq 5934
    end

    it "works for the input file" do
      input = File.readlines("spec/fixtures/day_06.txt").first

      expect(Day06.part_1(input)).to eq 6189
    end
  end

  context "part 2" do
  end
end
