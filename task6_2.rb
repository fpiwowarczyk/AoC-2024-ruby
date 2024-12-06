# frozen_string_literal:true

def main
  base_grid = []
  rows = []
  File.readlines('task6.data', chomp: true).each_with_index do |line, i|
    base_grid[i] = line.split('')
    rows << line
  end

  columns = Array.new(base_grid[0].length, '')
  base_grid.each do |row|
    row.each_with_index do |cell, j|
      columns[j] += cell
    end
  end

  grid = base_grid.dup

  limit = 20_000
  loops = 0
  number_of_iterations = grid.length * grid[0].length
  it = 0

  grid.each_with_index do |row, swap_y|
    row.each_with_index do |_cell, swap_x|
      print "Checking #{swap_x}, #{swap_y} iteration: #{it}/#{number_of_iterations}\n"
      next if grid[swap_y][swap_x] == '#' || grid[swap_y][swap_x] == '^'

      grid[swap_y][swap_x] = '#'
      res = loop_checking(grid, limit)
      loops += 1 if limit == res
      grid[swap_y][swap_x] = '.'
      it += 1
    end
  end

  print "Loops: #{loops}\n"
end

def find_symbol(symbol, grid)
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      next unless cell == symbol

      return [x, y]
    end
  end
end

def check_next(x, y, grid)
  grid[y][x]
end

def print_grid(x, y, grid)
  grid.each_with_index do |row, c_y|
    row.each_with_index do |cell, c_x|
      if c_x == x && c_y == y
        print '^'
        next
      end
      print cell
    end
    print "\n"
  end
  print "\n"
end

def replace_with(x, y, grid, symbol)
  grid[y][x] = symbol
end

def loop_checking(grid, limit)
  res = find_symbol('^', grid)
  x = res[0]
  y = res[1]

  direction = 'up'

  step_count = 0
  while x.positive? && x < grid[0].length - 1 && y.positive? && y < grid.length - 1 && step_count < limit
    case direction
    when 'up'
      n = check_next(x, y - 1, grid)
      if n == '#'
        direction = 'right'
        next
      end
      y -= 1

    when 'right'
      n = check_next(x + 1, y, grid)
      if n == '#'
        direction = 'down'
        next
      end
      x += 1

    when 'down'
      n = check_next(x, y + 1, grid)
      if n == '#'
        direction = 'left'
        next
      end
      y += 1
    when 'left'
      n = check_next(x - 1, y, grid)
      if n == '#'
        direction = 'up'
        next
      end
      x -= 1

    else
      puts "Invalid direction: #{direction}"
    end
    step_count += 1

  end
  step_count
end

main
