class Day01
  def self.part_1(input)
    array = input.split(/\n/).map(&:to_i)
    _part_1(array[0], array[1..-1], 0)
  end

  def self.part_2(input)
    array = input.split(/\n/).map(&:to_i)
    _part_2(array[0], array[1..-1], 0)
  end

  private

  def self._part_1(head, tail, sum)
    if tail[0].nil?
      sum
    else
      new_sum = tail[0] > head ? sum + 1 : sum
      _part_1(tail[0], tail[1..-1], new_sum)
    end
  end

  def self._part_2(head, tail, sum)
    if tail[0].nil?
      sum
    else
      new_sum = tail[0..2].sum > head ? sum + 1 : sum
      _part_2(tail[0..2].sum, tail[1..-1], new_sum)
    end
  end
end
