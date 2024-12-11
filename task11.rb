# frozen_string_literal:true

def main
  stones = File.open('task11.data', 'r').read.split(' ')

  number_of_blinks = 3

  (1..number_of_blinks).each do |blink|
    i = 0
    while i < stones.length
      if stones[i] == '0'
        stones[i] = '1'
      elsif stones[i].length.even?
        first, second = stones[i].chars.each_slice(stones[i].length / 2).map(&:join)
        stones[i] = first.to_i.to_s
        stones.insert(i + 1, second.to_i.to_s)
        i += 1
      else
        stones[i] = (stones[i].to_i * 2024).to_s
      end

      i += 1
    end
    p stones
    print "Number of stones #{stones.length} after: #{blink} blink\n" # 204035
  end
end

main
