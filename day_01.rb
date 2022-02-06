require_relative "helper_methods"

class Day01
  extend HelperMethods

  def self.part_1(input)
    parsed_input = input.split(/\n/).map(&:to_i)
    _part_1(parsed_input, 0)
  end

  def self.part_2(input)
    parsed_input = input.split(/\n/).map(&:to_i)
    _part_2(parsed_input, 0)
  end

  private

  def self._part_1(remaining_input, sum)
    head, tail = cons(remaining_input)

    if tail[0].nil?
      sum
    else
      new_sum = tail[0] > head ? sum + 1 : sum
      _part_1(tail, new_sum)
    end
  end

  def self._part_2(remaining_input, sum, sliding_window=nil)
    head, tail = cons(remaining_input)
    sliding_window ||= head

    if tail[0].nil?
      sum
    else
      next_window = tail[0..2].sum
      new_sum = next_window > sliding_window ? sum + 1 : sum
      _part_2(tail, new_sum, next_window)
    end
  end
end
