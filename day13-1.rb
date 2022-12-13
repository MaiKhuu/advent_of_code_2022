require "json"

def right_order?(left, right)
  l_length = left.class == Array ? left.length : 1
  r_length = right.class == Array ? right.length : 1
  
  min_length = l_length < r_length ? l_length : r_length
  
  for i in 0..min_length-1 do
    l_item = left[i]
    r_item = right[i]
    
    if l_item.class == Integer && r_item.class == Integer
      return true if l_item < r_item
      return false if l_item > r_item
      next
    end
    
    if l_item.class == Array && r_item.class == Array
      recursive = right_order?(l_item, r_item)
      return recursive unless recursive.nil?
      next
    end
  
    if l_item.class == Integer
      l_item = [l_item]
    elsif r_item.class == Integer
      r_item = [r_item]
    end
    recursive = right_order?(l_item, r_item)
    return recursive unless recursive.nil?
  end  
  
  return true if l_length < r_length
  return false if l_length > r_length
end

raw_input = File.readlines("input.txt").map(&:chomp)
count = 0

raw_input.each_with_index do |_, i|
  next unless (i+1) % 3 == 1
  left_arr = JSON.parse(raw_input[i])
  right_arr = JSON.parse(raw_input[i+1])
  count += (i / 3)+1 if right_order?(left_arr, right_arr)
end

p count