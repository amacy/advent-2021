require_relative "helper_methods"

class Day04
  extend HelperMethods

  def self.part_1(input)
		numbers, boards = _parse_input(input)
    _part_1(numbers, boards)
  end

  def self.part_2(input)
		numbers, boards = _parse_input(input)
    _part_2(numbers, boards)
  end

  private

  def self._part_1(numbers, boards)
    winning_number, remaining_numbers = cons(numbers)
    updated_boards = _update_boards(winning_number, boards)

    if winning_board = (_winning_row(updated_boards) || _winning_column(updated_boards))
      _calculate_total(winning_board, winning_number)
    else
      _part_1(remaining_numbers, updated_boards)
    end
  end

  def self._part_2(numbers, boards)
    winning_number, remaining_numbers = cons(numbers)
    binding.pry if winning_number.nil?
    updated_boards = _update_boards(winning_number, boards)

    if winning_board = _winning_row(updated_boards)
      remaining_boards = _remove_board(winning_board, updated_boards)

      if remaining_boards.length == 0
        _calculate_total(winning_board, winning_number)
      else
        _part_2(remaining_numbers, remaining_boards)
      end
    elsif winning_board = _winning_column(updated_boards)
      flipped_boards = _flip_boards(updated_boards)
      remaining_boards = _remove_board(winning_board, flipped_boards)

      if remaining_boards.length == 0
        _calculate_total(winning_board, winning_number)
      else
        _part_2(remaining_numbers, remaining_boards)
      end
    else
      _part_2(remaining_numbers, updated_boards)
    end
  end

  def self._remove_board(board_to_remove, all_boards)
    numbers_to_find = board_to_remove.first.map(&:first)

    all_boards.select do |board|
      board.first.map(&:first) != numbers_to_find
    end
  end

  def self._calculate_total(final_board, final_number)
    losing_numbers = final_board.flatten(1).map do |board_number|
      board_number.first if board_number.last == "loser"
    end.compact

    losing_numbers.sum * final_number
  end

  def self._update_boards(winning_number, boards)
    boards.map do |board|
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
    _winning_row(_flip_boards(boards))
  end

  def self._flip_boards(boards)
		boards.map do |board|
			(0..board.length - 1).map do |index|
				board.map { |row| row[index] }
			end
		end
  end
end
