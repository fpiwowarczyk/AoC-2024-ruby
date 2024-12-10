# frozen_string_literal:true

Point = Struct.new(:x, :y, :val, keyword_init: true)

def main
  map = Map.new(File.open('task10_example.data', 'r').read)

  sum_score = 0
  map.trailhead.each do |trailhead|
    p "Trailhead: #{trailhead.x}, #{trailhead.y}: found #{map.reach_top_different_routes(trailhead,
                                                                                         []).uniq.length} top reaching points"
    sum_score += map.reach_top_different_routes(trailhead, []).uniq.length
  end

  print "Sum score: #{sum_score}\n"
end

class Map
  attr_reader :grid

  def initialize(input)
    @grid = read_grid(input)
  end

  def read_grid(input)
    grid = []
    input.split("\n").each_with_index do |line, y|
      grid[y] = []
      p = line.split('')
      p.each_with_index do |val, x|
        grid[y] << Point.new(x: x, y: y, val: val)
      end
    end
    grid
  end

  def trailhead
    trailheads = []
    @grid.each do |line|
      line.each do |point|
        trailheads << point if point.val == '0'
      end
    end
    trailheads
  end

  def point(x, y)
    # Just non existing void point
    return Point.new(x: -1, y: -1, val: -1) if x.negative? || y.negative? || x >= @grid[0].length || y >= @grid.length

    @grid[y][x]
  end

  def get_surrounding(point)
    [
      point(point.x, point.y - 1),
      point(point.x + 1, point.y),
      point(point.x, point.y + 1),
      point(point.x - 1, point.y)
    ]
  end

  def reach_top_different_routes(point, shared_top_points)
    if point.val.to_i == 9
      shared_top_points << point
      return
    end

    get_surrounding(point).select { |p| p.val.to_i == point.val.to_i + 1 }.each do |p|
      reach_top_different_routes(p, shared_top_points)
    end
    shared_top_points
  end

  def can_reach(point); end
end

main
