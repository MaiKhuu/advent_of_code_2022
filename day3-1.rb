def split_in_2(arr)
  half_size = arr.size / 2
  return arr[0..half_size-1], arr[half_size..arr.size-2]
end

def find_same_char(string1, string2)
  arr1 = string1.chars
  arr2 = string2.chars
  arr1.each do |c|
    return c if arr2.include?(c)
  end
end

main = []

File.readlines("input.txt").each do |line|
  str1, str2 = split_in_2(line)
  main << [str1, str2]
end

points = {}
("a".."z").to_a.each do |c|
  points[c] = c.ord - 96
end
("A".."Z").to_a.each do |c|
  points[c] = c.ord - 38
end

result = main.map { |string1, string2| find_same_char(string1, string2) }
p result.map{ |c| points[c] }.sum