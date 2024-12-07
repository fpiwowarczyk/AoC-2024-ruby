# frozen_string_literal:true

def main
  lines = File.open('task7.data', 'r').read.split("\n")
  calibrations = {}
  lines.each do |line|
    splitted_line = line.split(':')
    print "DUPLICATE\n" unless calibrations[splitted_line[0].to_i].nil?

    calibrations[splitted_line[0].to_i] = splitted_line[1].split(' ').map(&:to_i)
  end

  result = 0

  calibrations.each do |key, value|
    result += key if can_combine(key, value)
  end

  print "Total calibration result: #{result}\n" # 4226405, 4998764814652
end

def can_combine(key, value)
  operators = Array.new(value.length - 1, '+')

  indecses = (0..operators.length - 1).to_a

  combs = combinations(indecses, operators.length)
  combs.each do |comb|
    cpy = operators.dup
    comb.each do |replace|
      cpy[replace] = '*'
    end
    puts "#{cpy}"
    if do_calculation(cpy, value) == key
      puts 'SUCCESS!'
      return true
    end
  end

  false
end

def do_calculation(operators, value)
  result = value[0]
  operators.each_with_index do |operator, i|
    case operator
    when '+'
      result += value[i + 1]
    when '*'
      result *= value[i + 1]
    end
  end

  result
end

def combinations(arr, n)
  return [[]] if n.zero?
  return [[]] if arr.empty?

  with_first = combinations(arr[1..], n - 1).map { |comb| [arr[0]] + comb }

  without_first = combinations(arr[1..], n)

  with_first + without_first
end

main
