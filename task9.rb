# frozen_string_literal:true

def main
  data = File.open('task9.data', 'r').read

  puts data
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

  p unpacked_data.join

  unpacked_data.each_with_index do |char, i|
    next if char != '.'

    unpacked_data[i] = unpacked_data[unpacked_data.length - 1]
    unpacked_data.delete_at(-1)
    unpacked_data.delete_at(-1) while unpacked_data[unpacked_data.length - 1] == '.'
  end

  checksum = 0
  unpacked_data.each_with_index do |char, i|
    checksum += char.to_i * i
  end
  print "unpacked_data: #{unpacked_data.join('')} have checksum #{checksum}\n"
end

main
