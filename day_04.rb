require_relative "helper_methods"

class Day04
  extend HelperMethods

  def self.part_1(input)
		numbers, boards = _parse_input(input)
    _part_1(numbers, boards)
  end

  private

  def self._part_1(numbers, boards)
    winning_number, remaining_numbers = cons(numbers)

    updated_boards = boards.map do |board|
      board.map do |row|
        row.map do |board_number|
          if board_number[0] == winning_number
            [board_number[0], "winner"]
          else
            board_number
          end
        end
      end
    end

    if winning_board = (_winning_row(updated_boards) || _winning_column(updated_boards))
      losing_numbers = winning_board.flatten(1).map do |board_number|
        board_number.first if board_number.last == "loser"
      end.compact

      losing_numbers.sum * winning_number
    else
      _part_1(remaining_numbers, updated_boards)
    end
  end

	def self._parse_input(input)
    head, tail = cons(input.split(/\n/))
    boards = tail.each_slice(6).map do |slice|
      # split(" ") exludes empty strings
      slice[1..-1].map do |board|
        board.split(" ").map do |board_number|
          [board_number.to_i, "loser"]
        end
      end
    end

		[head.split(/,/).map(&:to_i), boards]
	end

  def self._winning_row(boards)
    boards.each do |board|
      board.each do |row|
        if row.map(&:last).uniq == ["winner"]
          return board
        end
      end
    end

    nil
  end

  def self._winning_column(boards)
		flipped_boards = boards.map do |board|
			(0..board.length - 1).map do |index|
				board.map { |row| row[index] }
			end
		end

    _winning_row(flipped_boards)
  end
end
