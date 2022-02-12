require_relative "helper_methods"

class Day08
  extend HelperMethods

  SIGNAL_COUNT = {
    2 => 1,
    4 => 4,
    3 => 7,
    7 => 8,
  }

  def self.part_1(input)
		parsed_input = _parse_input(input)
    _part_1(parsed_input)
  end

  private

  def self._part_1(parsed_input)
    parsed_input.select do |signal|
      SIGNAL_COUNT[signal.length]
    end.count
  end

  def self._parse_input(input)
    input.split(/\n/).map do |line|
      line.split(/ \| /).last.split(/ /)
    end.flatten
  end
end
