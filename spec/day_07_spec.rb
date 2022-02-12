require_relative "../day_07"

RSpec.describe Day07 do
  context "part 1" do
    it "works for the sample input" do
      input = "16,1,2,0,4,2,7,1,2,14"

      expect(Day07.part_1(input)).to eq 37
    end

    it "works for the input file" do
      input = File.readlines("spec/fixtures/day_07.txt").first

      expect(Day07.part_1(input)).to eq 348664
    end
  end

  context "part 2" do
  end
end
