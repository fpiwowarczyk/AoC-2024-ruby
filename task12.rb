# frozen_string_literal:true

def main
  map = Map.new(File.readlines('task12.data', chomp: true))

  map.grid.each do |line|
    line.each do |cell|
      map.find_region(cell)
    end
  end

  print "Finished map\n"

  price = 0
  map.regions.each do |cells|
    print "Progress #{map.regions.index(cells)}/#{map.regions.length}\n"
    fences = 0
    cells.each do |cell|
      fences += 4 - map.get_neighbours(cell, cell.val).length
    end
    price += fences * cells.length
  end

  print "Price: #{price}\n"
end

Cell = Struct.new(:val, :x, :y)

class Map
  attr_reader :grid, :regions

  def initialize(input)
    @regions = []
    @grid = []
    input.each_with_index do |line, y|
      @grid[y] = []
      line.each_char.with_index do |cell, x|
        @grid[y] << Cell.new(cell, x, y)
      end
    end
  end

  def find_region(cell)
    @regions.each do |region|
      return region if region.include?(cell)
    end

    region = [cell]
    n = get_neighbours(cell, cell.val).reject { |c| region.include?(c) }
    until n.empty?
      new_n = []
      n.each do |neigh|
        region << neigh
        new_n += get_neighbours(neigh, neigh.val).reject { |c| region.include?(c) }
      end
      n = new_n.uniq
    end
    @regions << region
    region
  end

  def get_neighbours(cell, val)
    n = []
    n << get_cell(cell.x, cell.y - 1) if get_cell(cell.x, cell.y - 1).val == val
    n << get_cell(cell.x, cell.y + 1) if get_cell(cell.x, cell.y + 1).val == val
    n << get_cell(cell.x - 1, cell.y) if get_cell(cell.x - 1, cell.y).val == val
    n << get_cell(cell.x + 1, cell.y) if get_cell(cell.x + 1, cell.y).val == val
    n
  end

  def get_cell(x, y)
    return Cell.new('-1', -1, -1) if y < 0 || y >= @grid.length || x < 0 || x >= @grid[y].length

    @grid[y][x]
  end

  def cell_in_regions(cell)
    @regions.select { |_, cells| cells.include?(cell) }.keys
  end
end

main
