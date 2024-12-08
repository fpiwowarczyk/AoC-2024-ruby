# frozen_string_literal:true

def main
  map = Map.new(File.open('task8.data', 'r').read)

  map.anthenas.each do |a|
    map.anthenas.each do |a2|
      next if a == a2 || a.val != a2.val

      res_points = find_resonant_point(a.x, a.y, a2.x, a2.y, 100)

      res_points.each { |r| puts "#{r.x}, #{r.y}" }
      res_points.each do |res_point|
        map.replace_with(res_point.x, res_point.y, '#')
      end
    end
  end

  map.show

  print "Antinodes: #{map.signs_number('#')}\n"
end

def find_resonant_point(a1x, a1y, a2x, a2y, n)
  points = []
  n.times do |i|
    res_point_x = a1x + i * (a2x - a1x)
    res_point_y = a1y + i * (a2y - a1y)
    points << Resonant_Point.new(res_point_x, res_point_y)
  end
  points
end

class Resonant_Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

class Anthena
  attr_reader :val, :x, :y

  def initialize(val, x, y)
    @val = val
    @x = x
    @y = y
  end

  def ==(other)
    @x == other.x && @y == other.y
  end

  def dist(other)
    Math.sqrt((@x - other.x)**2 + (@y - other.y)**2)
  end
end

class Map
  attr_reader :grid, :anthenas

  def initialize(input)
    @grid = read_grid(input)
    @grid_antinodes = read_grid(input)
    @anthenas = find_anthenas
  end

  def point(x, y)
    @grid[y][x]
  end

  def read_grid(input)
    grid = []
    input.split("\n").each_with_index do |line, y|
      grid[y] = line.split('')
    end
    grid
  end

  def signs_number(sign)
    result = 0
    @grid_antinodes.each do |row|
      row.each do |cell|
        result += 1 if cell == sign
      end
    end
    result
  end

  def replace_with(x, y, sign)
    return if x.negative? || x >= @grid[0].length || y.negative? || y >= @grid.length

    @grid_antinodes[y][x] = sign
  end

  def show
    puts 'Before:'

    @grid.each do |row|
      row.each do |cell|
        print cell
      end
      print "\n"
    end

    puts 'After:'

    @grid_antinodes.each do |row|
      row.each do |cell|
        print cell
      end
      print "\n"
    end
  end

  def find_anthenas
    anthenas = []
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        anthenas << Anthena.new(cell, x, y) if cell != '.'
      end
    end
    anthenas
  end
end

main
