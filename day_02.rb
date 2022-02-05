class Day02
  def self.part_1(input)
    array = input.split(/\n/)
    _part_1(array[0], array[1..-1], 0, 0)
  end

  def self.part_2(input)
    array = input.split(/\n/)
    _part_2(array[0], array[1..-1], 0, 0, 0)
  end

  private

  def self._part_1(head, tail, horizontal, depth)
    if head.nil?
      horizontal * depth
    else
      instruction, amount = head.split(/ /)

      case instruction
      when "forward"
        _part_1(
          tail[0],
          tail[1..-1],
          horizontal + amount.to_i,
          depth,
        )
      when "down"
        _part_1(
          tail[0],
          tail[1..-1],
          horizontal,
          depth + amount.to_i,
        )
      when "up"
        _part_1(
          tail[0],
          tail[1..-1],
          horizontal,
          depth - amount.to_i,
        )
      end
    end
  end

  def self._part_2(head, tail, horizontal, depth, aim)
    if head.nil?
      horizontal * depth
    else
      instruction, amount = head.split(/ /)

      case instruction
      when "forward"
        _part_2(
          tail[0],
          tail[1..-1],
          horizontal + amount.to_i,
          depth + (aim * amount.to_i),
          aim,
        )
      when "down"
        _part_2(
          tail[0],
          tail[1..-1],
          horizontal,
          depth,
          aim + amount.to_i,
        )
      when "up"
        _part_2(
          tail[0],
          tail[1..-1],
          horizontal,
          depth,
          aim - amount.to_i,
        )
      end
    end
  end
end
