# frozen_string_literal:true

def main
  input = File.open('task3.data', 'r').read

  re_dont = /don't\(\)/
  re_do = /do\(\)/

  match_dont = input.match(re_dont)

  while match_dont
    start_index = match_dont.begin(0)

    match_do = input[start_index..input.length].match(re_do) # match only after dont
    unless match_do
      to_cut = input[start_index..input.length]
      input = input.sub(to_cut, '')
      match_dont = false
      next
    end

    end_index = match_do.end(0) + start_index

    to_cut = input[start_index..end_index - 1]
    input = input.sub(to_cut, '')

    match_dont = input.match(re_dont)
  end

  re_mul = /mul\([0-9]{1,3},[0-9]{1,3}\)/

  result = 0
  input.scan(re_mul) do |m|
    result += execute_mul(m)
  end
  print "result: #{result}\n"
end

def execute_mul(str)
  numbers = str.scan(/\d+/).map(&:to_i)
  numbers[0] * numbers[1]
end

main
