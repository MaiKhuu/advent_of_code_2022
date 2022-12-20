def move(arr, num_tuple)
  org_index = num_tuple.first
  move_num = num_tuple
  old_index = nil
  arr.each_with_index{ |num, i| old_index = i if num.first == org_index }
  new_index = (old_index + move_num.last) % (arr.size-1)
  new_index = arr.size-1 if new_index.zero?
  arr.delete_at(old_index)
  arr.insert(new_index, move_num)
end

raw_input = File.readlines("input.txt").map(&:chomp)

org_list = raw_input.map.with_index { |num, i| [i, num.to_i] }
working_list = org_list.clone

org_list.each_with_index do |num|
  move(working_list, num)
end

zero_i = nil
working_list.each_with_index { |n, i| zero_i = i if n.last.zero? }

num_1000 = working_list[(1000 + zero_i) % working_list.size]
num_2000 = working_list[(2000 + zero_i) % working_list.size]
num_3000 = working_list[(3000 + zero_i) % working_list.size]

p [num_1000, num_2000, num_3000].map{ |tuple| tuple.last }.sum