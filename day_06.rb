require_relative "helper_methods"

class Day06
  extend HelperMethods

  def self.part_1(input, total_days)
		parsed_input = _parse_input(input)
    _part_1(parsed_input, 0, total_days)
  end

  private

  def self._part_1(lanternfish, current_day, total_days)
    if current_day == total_days
      lanternfish.values.sum
    else
      new_lanternfish = lanternfish.keys.inject({}) do |hash, days_remaining|
        previous_count = lanternfish[days_remaining]

        if days_remaining == 0
          hash[6] ||= 0
          hash[6] += previous_count
          hash[8] ||= 0
          hash[8] += previous_count
        else
          hash[days_remaining - 1] ||= 0
          hash[days_remaining - 1] += previous_count
        end

        hash
      end

      _part_1(new_lanternfish, current_day + 1, total_days)
    end
  end

  def self._parse_input(input)
    input.split(/,/).map(&:to_i).inject({}) do |hash, days_remaining|
      hash[days_remaining] ||= 0
      hash[days_remaining] += 1
      hash
    end
  end
end
