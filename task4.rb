# frozen_string_literal:true

def main
  grid = []
  rows = []
  File.readlines('task4.data', chomp: true).each_with_index do |line, i|
    grid[i] = line.split('')
    rows << line
  end

  columns = Array.new(grid[0].length, '')
  grid.each do |row|
    row.each_with_index do |cell, j|
      columns[j] += cell
    end
  end

  diag_one = Array.new(grid[0].length * 2, '')
  diag_two = Array.new(grid[0].length * 2, '')
  for n in 0..grid.length - 1
    for i in 0..n
      j = n - i
      diag_one[n] += grid[i][j]
      next if n == diag_one.length - n - 2

      diag_one[diag_one.length - 1 - n] += grid[grid.length - 1 - i][grid.length - 1 - j]
    end

    for i in 0..n
      j = n - i
      diag_two[n] += grid[i][grid.length - 1 - j]

      next if n == diag_one.length - n - 2

      diag_two[diag_two.length - 1 - n] += grid[grid.length - 1 - i][j]

    end
  end

  total_findings = 0

  puts 'Rows'
  rows.each do |row|
    print "#{row}\n"
    total_findings += search_for_word_in_string(row, 'XMAS')
  end

  puts 'Columns'
  columns.each do |column|
    print "#{column}\n"
    total_findings += search_for_word_in_string(column, 'XMAS')
  end

  puts ' Diag one'
  diag_one.each do |diag|
    print "#{diag}\n"
    total_findings += search_for_word_in_string(diag, 'XMAS')
  end

  puts 'Diag two'
  diag_two.each do |diag|
    print "#{diag}\n"
    total_findings += search_for_word_in_string(diag, 'XMAS')
  end

  print "result: #{total_findings}\n"
end

def search_for_word_in_string(str, word)
  result = 0
  str.scan(/#{word}/) do
    result += 1
  end
  str.scan(/#{word.reverse}/) do
    result += 1
  end
  result
end

main
