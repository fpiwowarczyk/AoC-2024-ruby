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

  to_delete_indx = []
  updates.each_with_index do |update, i|
    update.each_with_index do |val, ind|
      befores = rules[val]
      befores = [] if befores.nil?
      to_break = false
      befores.each do |before|
        next unless !update.find_index(before).nil? && update.find_index(before) <= ind

        to_break = true
        break
      end
      break if to_break
      next unless ind == update.length - 1

      to_delete_indx << i
    end
  end

  to_delete_indx.each_with_index do |ind, i|
    updates.delete_at(ind - i)
  end

  result = 0
  puts "rules #{rules.length}: #{rules} "
  updates.each do |update|
    result += fix(rules, update)[update.length / 2]
  end

  puts "result: #{result}"
end

def fix(rules, update)
  loop do
    swaps_were_done = false
    update.each_with_index do |val, ind|
      before_array = rules[val]
      before_array = [] if before_array.nil?
      before_array.each do |before|
        next unless !update.find_index(before).nil? && update.find_index(before) <= ind

        update[ind], update[update.find_index(before)] = update[update.find_index(before)], update[ind]
        swaps_were_done = true
      end
    end
    return update unless swaps_were_done
  end
end

main
