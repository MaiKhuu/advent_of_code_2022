raw_input = File.readlines("input.txt").map(&:chomp)

result = 0
total = 1
cycle_count = 0
count_at = [20, 60, 100, 140, 180, 220]

raw_input.each_with_index do |line, i|
  num = line.split(" ")[1].to_i
  cycle_count += 1
  result += cycle_count * total if count_at.include?(cycle_count)
  next if num.zero?
  cycle_count += 1
  result += cycle_count * total if count_at.include?(cycle_count)
  total += num
end

p result