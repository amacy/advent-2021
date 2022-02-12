require_relative "helper_methods"

class Day07
  extend HelperMethods

  def self.part_1(input)
		parsed_input = _parse_input(input)
    avg = parsed_input.sum / parsed_input.length
    (0..avg).map do |candidate|
      parsed_input.map do |crab|
        positions = [candidate, crab].sort
        positions.max - positions.min
      end.sum
    end.min
  end

  private

  def self._parse_input(input)
    input.split(/,/).map(&:to_i)
  end
end
