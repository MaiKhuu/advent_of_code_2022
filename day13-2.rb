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
all_packets = [[[2]], [[6]]]

raw_input.each do |line|
  all_packets << JSON.parse(line) unless line.empty?
end

for i in (0..all_packets.length-2) do
  for j in (i..all_packets.length-1) do
    if !right_order?(all_packets[i], all_packets[j])
      temp = all_packets[i]
      all_packets[i] = all_packets[j]
      all_packets[j] = temp
    end
  end
end

p (all_packets.index([[2]]) + 1) * (all_packets.index([[6]]) + 1)