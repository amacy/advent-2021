require_relative "helper_methods"

class Day09
  extend HelperMethods

  def self.part_1(input)
		parsed_input = _parse_input(input)
    _part_1(parsed_input, 0, 0, [])
  end

  private

  def self._part_1(grid, x, y, low_points)
    column_count = grid.first.length
    row_count = grid.length
    valid_xs = 0..column_count - 1
    valid_ys = 0..row_count - 1

    puts [x, y].inspect
    if y == row_count
      low_points.inject(0) do |sum, node|
        _x, _y = node
        sum + grid[_y][_x] + 1
      end
    else
      neighbors_1 = [x - 1, x + 1].select do |candidate|
        valid_xs.include?(candidate)
      end.map { |_x| [_x, y] }
      neighbors_2 = [y - 1, y + 1].select do |candidate|
        valid_ys.include?(candidate)
      end.map { |_y| [x, _y] }

      next_x, next_y, new_low_points = _evaluate_neighbors(
        grid,
        x,
        y,
        low_points,
        neighbors_1 + neighbors_2,
        valid_xs,
      )

      _part_1(grid, next_x, next_y, new_low_points)
    end
  end

  def self._evaluate_neighbors(grid, x, y, low_points, neighbors, valid_xs)
    if neighbors.any? { |_x, _y| grid[_y][_x] < grid[y][x] }
      if x == valid_xs.last
        [0, y + 1, low_points]
      else
        [x + 1, y, low_points]
      end
    else
      if x == valid_xs.max
        [0, y + 1, low_points + [[x, y]]]
      else
        [x + 1, y, low_points + [[x, y]]]
      end
    end
  end

  def self._parse_input(input)
    input.split(/\n/).map { |line| line.split(//).map(&:to_i) }
  end
end
