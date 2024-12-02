# frozen_string_literal:true

def contains_error(last_item, el, increasing)
  last_item == el ||
    (el < last_item && increasing) ||
    (el > last_item && !increasing) ||
    (increasing && el - last_item > 3) ||
    (!increasing && last_item - el > 3)
end

def safe(raport, can_skip)
  last_item = raport[0]
  increasing = raport[0] < raport[1]
  raport.each_with_index do |el, i|
    next if i.zero?

    if contains_error(last_item, el, increasing) && can_skip
      raport1 = raport.dup
      raport2 = raport.dup
      raport3 = raport.dup
      raport1.delete_at(i - 2)
      raport2.delete_at(i - 1)
      raport3.delete_at(i)
      res1 = safe(raport1, false)
      res2 = safe(raport2, false)
      res3 = safe(raport3, false)
      return res1 || res2 || res3
    elsif contains_error(last_item, el, increasing) && !can_skip
      return false
    end

    last_item = el
  end
  true
end

raports = []
File.readlines('task2.data', chomp: true).each do |line|
  raports << line.split(' ')
end

safe_raports = 0
raports.each do |raport|
  raport = raport.map(&:to_i)
  safe_raports += 1 if safe(raport.dup, true)
end

print "safe raports: #{safe_raports}\n"
