require_relative "../day_01"

RSpec.describe Day01 do
  context "part 1" do
    it "works for the sample input" do
      input = <<~INPUT
        199
        200
        208
        210
        200
        207
        240
        269
        260
        263
      INPUT

      expect(Day01.part_1(input)).to eq 7
    end

    it "works for the input file" do
      input = File.read("spec/fixtures/day_01.txt")

      expect(Day01.part_1(input)).to eq 1195
    end
  end
end
