# frozen_string_literal:true

def main
  input = File.open('task5.data', 'r').read.split("\n\n")
  rules = {}
  input[0].split("\n").map do |e|
    o = e.split('|')
    key = o[0].to_i
    value = o[1].to_i

    rules[key] ||= [] # Initialize as an empty array if key is missing
    rules[key] << value
  end
  updates = input[1].split("\n").map { |e| e.split(',').map(&:to_i) }

  result = 0
  puts "rules #{rules.length}: #{rules} "
  updates.each_with_index do |update, _i|
    update.each_with_index do |val, ind|
      befores = rules[val]
      to_break = false
      befores.each do |before|
        if !update.find_index(before).nil? && update.find_index(before) <= ind
          to_break = true
          break
        end
      end
      break if to_break
      next unless ind == update.length - 1

      result += update[update.length / 2]
    end
  end

  puts "result: #{result}" # 6814
end

main
