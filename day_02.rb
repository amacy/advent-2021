require_relative "helper_methods"

class Day02
  extend HelperMethods

  def self.part_1(input)
    parsed_input = input.split(/\n/)
    _part_1(parsed_input, 0, 0)
  end

  def self.part_2(input)
    parsed_input = input.split(/\n/)
    _part_2(parsed_input, 0, 0, 0)
  end

  private

  def self._part_1(remaining_input, horizontal, depth)
    head, tail = cons(remaining_input)

    if head.nil?
      horizontal * depth
    else
      instruction, amount = head.split(/ /)

      case instruction
      when "forward"
        _part_1(
          tail,
          horizontal + amount.to_i,
          depth,
        )
      when "down"
        _part_1(
          tail,
          horizontal,
          depth + amount.to_i,
        )
      when "up"
        _part_1(
          tail,
          horizontal,
          depth - amount.to_i,
        )
      end
    end
  end

  def self._part_2(remaining_input, horizontal, depth, aim)
    head, tail = cons(remaining_input)

    if head.nil?
      horizontal * depth
    else
      instruction, amount = head.split(/ /)

      case instruction
      when "forward"
        _part_2(
          tail,
          horizontal + amount.to_i,
          depth + (aim * amount.to_i),
          aim,
        )
      when "down"
        _part_2(
          tail,
          horizontal,
          depth,
          aim + amount.to_i,
        )
      when "up"
        _part_2(
          tail,
          horizontal,
          depth,
          aim - amount.to_i,
        )
      end
    end
  end
end
