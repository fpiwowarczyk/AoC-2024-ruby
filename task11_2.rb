# frozen_string_literal:true

Stone = Struct.new(:value, :number)

def main
  data = File.open('task11.data', 'r').read.split(' ')

  stones = []
  data.each do |d|
    stones << Stone.new(d, 1)
  end

  number_of_blinks = 75

  (1..number_of_blinks).each do |blink|
    to_append = []
    stones.each do |stone|
      if stone.value == '0'
        stone.value = '1'
      elsif stone.value.length.even?
        first, second = stone.value.chars.each_slice(stone.value.length / 2).map(&:join)
        stone.value = first.to_i.to_s
        to_append << Stone.new(second.to_i.to_s, stone.number)
      else
        stone.value = (stone.value.to_i * 2024).to_s
      end
    end

    stones += to_append

    reduced = stones.each_with_object({}) do |stone, acc|
      if acc.key?(stone.value)
        acc[stone.value] += stone.number
      else
        acc[stone.value] = stone.number
      end
    end

    stones = reduced.map { |value, number| Stone.new(value, number) }

    p "#{blink}/#{number_of_blinks}"
  end

  print "Number of stones #{stones.map(&:number).sum} after #{number_of_blinks} blink\n"
end

main
