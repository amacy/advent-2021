require_relative "helper_methods"

class Day06
  extend HelperMethods

  def self.part_1(input)
		parsed_input = _parse_input(input)
    _part_1(parsed_input, 0)
  end

  private

  def self._part_1(lanternfish, day)
    if day == 80
      lanternfish.length
    else
      new_lanternfish = lanternfish.map do |fish|
        if fish == 0
          [6, 8]
        else
          fish - 1
        end
      end.flatten

      _part_1(new_lanternfish, day + 1)
    end
  end

  def self._parse_input(input)
    input.split(/,/).map(&:to_i)
  end
end
