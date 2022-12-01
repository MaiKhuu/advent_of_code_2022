raw = File.readlines("input.txt")

arr = [[]]
i = 0

raw.each do |line|
  if line == "\n"  
    i += 1
    arr << []
  else
    arr[i] << line.to_i 
  end
end

puts (arr.map { |sub_arr| sub_arr.sum }).max
