# frozen_string_literal:true

def main
  input = File.open('task3.data', 'r').read

  re = /mul\([0-9]{1,3},[0-9]{1,3}\)/

  result = 0
  input.scan(re) do |m|
    result += execute_mul(m)
  end
  print "result: #{result}\n"
end

def execute_mul(str)
  numbers = str.scan(/\d+/).map(&:to_i)
  numbers[0] * numbers[1]
end

main
