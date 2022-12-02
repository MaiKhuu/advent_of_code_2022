raw = File.readlines("input.txt")

arr = raw.map {|line| line.split(" ") }

wins = { ["A", "X"] => 3, ["B", "Y"] => 3, ["C", "Z"] => 3,
         ["A", "Y"] => 6, ["B", "Z"] => 6, ["C", "X"] => 6 }
choices = { "X" => 1, "Y" => 2, "Z" => 3 }

result = 0
arr.each do |pair|
  result += choices[pair[1]]
  result += wins[pair].to_i
end

puts result