# frozen_string_literal:true

left = []
right = []
File.readlines('task1.data', chomp: true).each do |line|
  o = line.split(' ', 2)
  left << o[0].to_i
  right << o[1].to_i
end

similarity_score = 0

left.each_with_index do |l, _i|
  occur = 0
  right.each do |r|
    occur += 1 if l == r
  end

  similarity_score += l * occur
end

print similarity_score
