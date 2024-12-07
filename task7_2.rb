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

  check = 0
  calibrations.each do |key, value|
    result += key if can_combine(key, value)

    check += 1
    print "Check #{check}/#{calibrations.length}\n"
  end

  print "Total calibration result: #{result}\n" # 26813970734809 37598910447546
end

def can_combine(key, value)
  operators = Array.new(value.length - 1, '+')

  indecses = (0..operators.length - 1).to_a

  combs_mult = combinations(indecses, operators.length)

  combs_mult.each do |comb_mult|
    cpy = operators.dup
    ind = (0..comb_mult.length - 1).to_a
    combs_concat = combinations(ind, comb_mult.length)
    comb_mult.each do |replace|
      cpy[replace] = '*'
    end

    combs_concat.each do |comb_repl|
      cpy2 = cpy.dup
      repls = []
      comb_repl.each do |replace|
        found_mults = 0
        cpy2.each_with_index do |op, i|
          next unless op == '*'

          found_mults += 1

          repls << i if found_mults == replace + 1
        end
      end
      repls.each do |r|
        cpy2[r] = '|'
      end

      return true if do_calculation(cpy2, value) == key
    end
  end

  false
end

def do_calculation(operators, values)
  result = values[0]
  operators.each_with_index do |operator, i|
    case operator
    when '+'
      result += values[i + 1]
    when '*'
      result *= values[i + 1]
    when '|'
      result = (result.to_s + values[i + 1].to_s).to_i
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
