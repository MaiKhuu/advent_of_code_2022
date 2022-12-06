def first_marker_appears(arr)
  arr.each_with_index do |c, i|
    next if i < 3
    return i if arr[i-3..i].uniq == arr[i-3..i]
  end
end
  
raw_input = File.readlines("input.txt").map(&:chomp).map(&:chars)
raw_input.each do |arr|
  p first_marker_appears(arr) + 1
end
