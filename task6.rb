# frozen_string_literal:true

def main
  grid = []
  rows = []
  File.readlines('task6.data', chomp: true).each_with_index do |line, i|
    grid[i] = line.split('')
    rows << line
  end

  columns = Array.new(grid[0].length, '')
  grid.each do |row|
    row.each_with_index do |cell, j|
      columns[j] += cell
    end
  end

  res = find_symbol('^', grid)
  x = res[0]
  y = res[1]

  direction = 'up'
  puts "Starting position is #{find_symbol('^', grid)}"
  puts "Current position: #{x}, #{y}"
  print_grid(x, y, grid)

  while x.positive? && x < grid[0].length - 1 && y.positive? && y < grid.length - 1
    replace_with(x, y, grid, 'X')

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

    puts "Current position: #{x}, #{y}"
    print_grid(x, y, grid)
  end

  occupied = 1
  grid.each do |row|
    row.each do |cell|
      occupied += 1 if cell == 'X'
    end
  end

  puts "Occupied positions: #{occupied}"
end

def find_symbol(symbol, grid)
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      return [x, y] if cell == symbol
    end
  end
end

def check_next(x, y, grid)
  grid[y][x]
end

def print_grid(x, y, grid)
  puts `clear`
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

main
