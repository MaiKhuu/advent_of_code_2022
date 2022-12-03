def find_same_char(string1, string2, string3)
  result_12 = []
  arr1 = string1.chars
  arr2 = string2.chars
  arr3 = string3.chars
  arr1.each do |c|
    result_12 << c if arr2.include?(c)
  end
  result_12.each do |c|
    return c if arr3.include?(c)
  end
end

main = Array.new

input = File.readlines("input.txt")
input.each_with_index do |line, i|
  if (i % 3).zero?
    main.push([line.chomp])
  else
    main.last << line.chomp
  end
end

points = {}
("a".."z").to_a.each do |c|
  points[c] = c.ord - 96
end
("A".."Z").to_a.each do |c|
  points[c] = c.ord - 38
end

p main.map { |arr| points[find_same_char(arr[0], arr[1], arr[2])]  }.sum