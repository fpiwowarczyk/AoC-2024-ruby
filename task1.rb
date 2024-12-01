# frozen_string_literal:true

left = []
right = []
File.readlines('task1.data', chomp: true).each do |line|
  o = line.split(' ', 2)
  left << o[0].to_i
  right << o[1].to_i
end

left = left.sort
right = right.sort

sum = 0
left.each_with_index do |l, i|
  r = right[i]
  sum += if l > r
           l - r
         else
           r - l
         end
end

print sum # 1580061
