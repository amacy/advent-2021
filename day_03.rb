class Day03
  def self.part_1(input)
    array = input.split(/\n/).map { |line| line.split(//).map(&:to_i) }
    gamma_bit_counts = _count_gamma_bits(array[0], array[1..-1], [])

    gamma_rate = _gamma_rate(
      gamma_bit_counts,
      lambda { |bit| bit > (array.length / 2) ? 1 : 0 },
    )

    gamma_rate.to_i(2) * _epsilon_rate(gamma_rate).to_i(2)
  end

  def self.part_2(input)
    array = input.split(/\n/).map { |line| line.split(//).map(&:to_i) }
    gamma_bit_counts = _count_gamma_bits(array[0], array[1..-1], [])

    gamma_rate_function_1 = -> (gamma_bit_counts, array) {
      _gamma_rate(
        gamma_bit_counts,
        lambda { |bit| bit >= (array.length - bit) ? 1 : 0 },
      ).split(//).map(&:to_i)
    }

    oxygen_generator_rating = _oxygen_generator_or_co2_scrubber_rating(
      array,
      gamma_rate_function_1.call(gamma_bit_counts, array),
      gamma_rate_function_1,
      0,
    )

    gamma_rate_function_2 = -> (gamma_bit_counts, array) {
      puts 'another time thru'
      puts array.inspect
      _epsilon_rate(
        _gamma_rate(
          gamma_bit_counts,
          lambda { |bit|
            if array.length == 2
              puts "bit"
              puts bit
            end
            # bit > (array.length - bit) ? 1 : 0
            bit >= (array.length - bit) ? 1 : 0
          },
        )
      ).split(//).map(&:to_i)
    }

    co2_scrubber_rating = _oxygen_generator_or_co2_scrubber_rating(
      array,
      gamma_rate_function_2.call(gamma_bit_counts, array),
      gamma_rate_function_2,
      0,
    )
    puts oxygen_generator_rating.join
    puts oxygen_generator_rating.join.to_i(2)
    puts co2_scrubber_rating.join
    puts co2_scrubber_rating.join.to_i(2)

    oxygen_generator_rating.join.to_i(2) * co2_scrubber_rating.join.to_i(2)
  end

  private

  def self._count_gamma_bits(head, tail, array)
    if head.nil?
      array
    else
      new_array = head.map.with_index do |bit, index|
        bit + array[index].to_i
      end
      _count_gamma_bits(tail[0], tail[1..-1], new_array)
    end
  end

  def self._gamma_rate(bit_counts, count_function)
    bit_counts.map do |bit|
      count_function.call(bit)
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
        _count_gamma_bits(new_array[0], new_array[1..-1], []),
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
end
