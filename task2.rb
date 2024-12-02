# frozen_string_literal:true

def safe(raport)
  last_item = raport[0]
  increasing = raport[0] < raport[1]
  raport.each_with_index do |el, i|
    next if i.zero?

    return false if last_item == el ||
                    (el < last_item && increasing) ||
                    (el > last_item && !increasing) ||
                    (increasing && el - last_item > 3) ||
                    (!increasing && last_item - el > 3)

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
  safe_raports += 1 if safe(raport)
end

print "safe raports: #{safe_raports}\n"
