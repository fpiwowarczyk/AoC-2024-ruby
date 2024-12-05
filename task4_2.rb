# frozen_string_literal:true

def main
  grid = []
  File.readlines('task4_example.data', chomp: true).each_with_index do |line, i|
    grid[i] = line.split('')
  end
  total_findings = 0

  for i in 0..grid.length - 3
    for j in 0..grid.length - 3
      sub_array = [grid[i].slice(j, 3),
                   grid[i + 1].slice(j, 3),
                   grid[i + 2].slice(j, 3)]
      next unless sub_array[1][1] == 'A'

      mas = sub_array[0][0] + sub_array[1][1] + sub_array[2][2]
      if %w[MAS SAM].include?(mas)
        sam = sub_array[0][2] + sub_array[1][1] + sub_array[2][0]
        total_findings += 1 if %w[MAS SAM].include?(sam)
      end
    end
  end

  print "result: #{total_findings}\n"
end

main
