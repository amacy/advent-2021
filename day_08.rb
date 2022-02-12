require_relative "helper_methods"

class Day08
  extend HelperMethods

  SIGNAL_COUNT = {
    2 => 1,
    4 => 4,
    3 => 7,
    7 => 8,
  }.freeze

  EIGHT = "abcdefg"

  CORRECT_DISPLAY = {
    "abcefg" => "0",
    "cf" => "1",
    "acdeg" => "2",
    "acdfg" => "3",
    "bcdf" => "4",
    "abdfg" => "5",
    "abdefg" => "6",
    "acf" => "7",
    EIGHT => "8",
    "abcdfg" => "9",
  }.freeze

  def self.part_1(input)
		parsed_input = _parse_input(input)
    output = parsed_input.map(&:last).flatten
    _easy_digits(output).count
  end

  def self.part_2(input)
		parsed_input = _parse_input(input)
    signal_patterns = parsed_input.map(&:first)
    output = parsed_input.map(&:last)

    signal_patterns.map.with_index do |signal_pattern, index|
      eight = _easy_digits(signal_pattern).find do |digit|
        digit.length == 7
      end

      _decode_number(_letter_hash(eight), output[index])
    end
  end

  private

  def self._decode_number(letter_hash, output)
    decoded_numbers = output.map do |coded_number|
      coded_number.split(//).map do |char|
        letter_hash[char]
      end.sort.join
    end

    decoded_numbers.inject("") do |string, decoded_number|
      binding.pry
      string + CORRECT_DISPLAY[decoded_number]
    end.to_i
  end

  def self._letter_hash(eight)
    eight.split(//).each_with_index.inject({}) do |hash, (char, index)|
      hash[char] = EIGHT[index]
      hash
    end
  end

  def self._easy_digits(parsed_input)
    parsed_input.select { |signal| SIGNAL_COUNT[signal.length] }
  end

  def self._parse_input(input)
    input.split(/\n/).map do |line|
      line.split(/ \| /).map do |section|
        section.split(/ /)
      end
    end
  end
end
