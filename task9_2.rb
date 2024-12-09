# frozen_string_literal:true

def main
  data = File.open('task9.data', 'r').read

  unpacked_data = []
  id = 0
  data.split('').each_with_index do |char, i|
    if i.even?
      char.to_i.times do
        unpacked_data << id
      end
      id += 1
    else
      char.to_i.times do
        unpacked_data << '.'
      end
    end
  end

  print "len #{unpacked_data.length}\n\n"

  p unpacked_data.join

  reversed_unpacked_data = unpacked_data.reverse

  last_el = reversed_unpacked_data[0]
  temp_el_array = [reversed_unpacked_data[0]]
  reversed_unpacked_data.each_with_index do |char, i|
    p "#{i}/#{reversed_unpacked_data.length}"
    next if i.zero? || char == '.'

    if char == last_el
      temp_el_array << char
    else
      counter = 0
      (0..unpacked_data.index(temp_el_array[0])).each do |j|
        if unpacked_data[j] == '.'
          counter += 1
        else
          counter = 0
        end
        next unless counter == temp_el_array.length

        index_start = unpacked_data.index(temp_el_array[0])

        dot_array = Array.new(counter, '.')
        unpacked_data[index_start..index_start + counter - 1] = dot_array
        unpacked_data[j - counter + 1..j] = temp_el_array

        break
      end
      temp_el_array = [char]
    end
    last_el = char
  end

  checksum = 0
  unpacked_data.each_with_index do |char, i|
    checksum += char.to_i * i
  end
  print "#{unpacked_data.join} len #{unpacked_data.length} have checksum #{checksum}\n" # 6408966987203
end

main
