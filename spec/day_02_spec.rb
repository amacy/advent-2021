require_relative "../day_02"

RSpec.describe Day01 do
  context "part 1" do
    it "works for the sample input" do
      input = <<~INPUT
        forward 5
        down 5
        forward 8
        up 3
        down 8
        forward 2
      INPUT

      expect(Day02.part_1(input)).to eq 150
    end

    it "works for the input file" do
      input = File.read("spec/fixtures/day_02.txt")

      expect(Day02.part_1(input)).to eq 1855814
    end
  end

  context "part 2" do
    it "works for the sample input" do
      input = <<~INPUT
        forward 5
        down 5
        forward 8
        up 3
        down 8
        forward 2
      INPUT

      expect(Day02.part_2(input)).to eq 900
    end

    it "works for the input file" do
      input = File.read("spec/fixtures/day_02.txt")

      expect(Day02.part_2(input)).to eq 1845455714
    end
  end
end
