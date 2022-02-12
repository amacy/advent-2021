require_relative "helper_methods"

class Day05
  extend HelperMethods

  def self.part_1(input)
		parsed_input = _parse_input(input)
    _part_1(parsed_input, [])
  end

  def self.part_2(input)
		parsed_input = _parse_input(input)
    _part_1(parsed_input, []) do |nodes, grid|
      _populate_diagonal(nodes, grid)
    end
  end

  private

  def self._part_1(nodes, grid, &diagonal_function)
    head, tail = cons(nodes)
    node_1, node_2 = head
    x_1, y_1 = node_1
    x_2, y_2 = node_2

    if node_1.nil?
      grid.inject(0) do |sum, row|
        if row.nil?
          sum
        else
          sum + row.compact.count { |value| value > 1 }
        end
      end
    elsif x_1 == x_2
      line_ys = [y_1, y_2]

      new_grid = _populate_vertical(
        (line_ys.min..line_ys.max).to_a,
        x_1,
        grid,
      )

      _part_1(tail, new_grid, &diagonal_function)
    elsif y_1 == y_2
      line_xs = [x_1, x_2]

      new_grid = _populate_horizontal(
        (line_xs.min..line_xs.max).to_a,
        y_1,
        grid,
      )
      _part_1(tail, new_grid, &diagonal_function)
    elsif block_given?
      diagonal_nodes = _generate_diagonal_nodes(node_1, node_2, [])
      new_grid = diagonal_function.call(diagonal_nodes, grid)
      _part_1(tail, new_grid, &diagonal_function)
		else
      _part_1(tail, grid, &diagonal_function)
    end
  end

  def self._generate_diagonal_nodes(start_node, end_node, nodes)
    x_1, y_1 = start_node
    x_2, y_2 = end_node

    if start_node == end_node
      nodes + [start_node]
    elsif nodes.uniq.length < nodes.length
      nodes.uniq
    elsif x_1 > x_2
      if y_1 > y_2
        _generate_diagonal_nodes(
          [x_1 - 1, y_1 - 1],
          [x_2 + 1, y_2 + 1],
          nodes + [start_node, end_node],
        )
      else
        _generate_diagonal_nodes(
          [x_1 - 1, y_1 + 1],
          [x_2 + 1, y_2 - 1],
          nodes + [start_node, end_node],
        )
      end
    else
      if y_1 > y_2
        _generate_diagonal_nodes(
          [x_1 + 1, y_1 - 1],
          [x_2 - 1, y_2 + 1],
          nodes + [start_node, end_node],
        )
      else
        _generate_diagonal_nodes(
          [x_1 + 1, y_1 + 1],
          [x_2 - 1, y_2 - 1],
          nodes + [start_node, end_node],
        )
      end
    end
  end

  def self._populate_diagonal(nodes, grid)
    if nodes.empty?
      grid
    else
      new_grid = grid.dup
      node, remaining_nodes = cons(nodes)
      x, y = node
      new_grid[y] ||= []
      new_grid[y][x] ||= 0
      new_grid[y][x] += 1
      _populate_diagonal(remaining_nodes, new_grid)
    end
  end

  def self._populate_horizontal(xs, y, grid)
    if xs.empty?
      grid
    else
      new_grid = grid.dup
      x, remaining_xs = cons(xs)
      new_grid[y] ||= []
      new_grid[y][x] ||= 0
      new_grid[y][x] += 1
      _populate_horizontal(remaining_xs, y, new_grid)
    end
  end

  def self._populate_vertical(ys, x, grid)
    if ys.empty?
      grid
    else
      new_grid = grid.dup
      y, remaining_ys = cons(ys)
      new_grid[y] ||= []
      new_grid[y][x] ||= 0
      new_grid[y][x] += 1
      _populate_vertical(remaining_ys, x, new_grid)
    end
  end

  def self._parse_input(input)
    input.split(/\n/).map do |line|
      line.split(/ -> /).map do |node|
        node.split(/,/).map(&:to_i)
      end
    end
  end
end
