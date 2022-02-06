require_relative "helper_methods"

class Day03
  extend HelperMethods

  def self.part_1(input)
    parsed_input = _parse_input(input)
    gamma_bit_counts = _count_gamma_bits(parsed_input, [])

    gamma_rate = _gamma_rate(gamma_bit_counts, parsed_input.length)

    bit_to_decimal(gamma_rate) *
      bit_to_decimal(_epsilon_rate(gamma_rate))
  end

  def self.part_2(input)
    parsed_input = _parse_input(input)
    gamma_bit_counts = _count_gamma_bits(parsed_input, [])

    oxygen_generator_rating_function = -> (gamma_bit_counts, array) {
      string_to_number_array(
        _gamma_rate(gamma_bit_counts, array.length)
      )
    }

    oxygen_generator_rating = _oxygen_generator_or_co2_scrubber_rating(
      parsed_input,
      oxygen_generator_rating_function.call(gamma_bit_counts, parsed_input),
      oxygen_generator_rating_function,
      0,
    )

    co2_scrubber_rating_function = -> (gamma_bit_counts, array) {
      string_to_number_array(
        _epsilon_rate(
          _gamma_rate(gamma_bit_counts, array.length)
        )
      )
    }

    co2_scrubber_rating = _oxygen_generator_or_co2_scrubber_rating(
      parsed_input,
      co2_scrubber_rating_function.call(gamma_bit_counts, parsed_input),
      co2_scrubber_rating_function,
      0,
    )

    bit_to_decimal(oxygen_generator_rating.join) *
      bit_to_decimal(co2_scrubber_rating.join)
  end

  private

  def self._count_gamma_bits(remaining_input, acc)
    head, tail = cons(remaining_input)

    if head.nil?
      acc
    else
      _count_gamma_bits(
        tail,
        head.map.with_index { |bit, index| bit + acc[index].to_i }
      )
    end
  end

  def self._gamma_rate(bit_counts, input_length)
    bit_counts.map do |bit|
      _count_function.call(bit, input_length)
    end.map(&:to_s).join
  end

  def self._epsilon_rate(gamma_rate)
    gamma_rate.split(//).map do |bit|
      bit == "1" ? "0" : "1"
    end.join
  end

  def self._oxygen_generator_or_co2_scrubber_rating(array, rate, rate_function, index)
    if array.length == 1
      array[0]
    else
      new_array = array.select { |binary| binary[index] == rate[index] }
      rate = rate_function.call(
        _count_gamma_bits(new_array, []),
        new_array,
      )

      _oxygen_generator_or_co2_scrubber_rating(
        new_array,
        rate,
        rate_function,
        index + 1,
      )
    end
  end

  def self._parse_input(input)
    input.split(/\n/).map { |string| string_to_number_array(string) }
  end

  def self._count_function
    lambda { |bit, input_length| bit >= (input_length - bit) ? 1 : 0 }
  end
end
