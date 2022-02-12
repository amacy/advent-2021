require_relative "helper_methods"

class Day07
  extend HelperMethods

  def self.part_1(input)
		parsed_input = _parse_input(input)
    _part_1(parsed_input, _avg(parsed_input))
  end

  def self.part_2(input)
		parsed_input = _parse_input(input)
    _part_1(parsed_input, _avg(parsed_input) * 2) do |delta|
      (1..delta).to_a.sum
    end
  end

  private

  def self._part_1(starting_positions, avg, &fuel_function)
    totals = (0..avg).map do |candidate|
      starting_positions.map do |crab|
        positions = [candidate, crab].sort
        delta = positions.max - positions.min
        if block_given?
          fuel_function.call(delta)
        else
          delta
        end
      end.sum
    end
      totals.min
  end

  def self._avg(parsed_input)
    parsed_input.sum / parsed_input.length
  end

  def self._parse_input(input)
    input.split(/,/).map(&:to_i)
  end
end
