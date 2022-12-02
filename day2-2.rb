raw = File.readlines("input.txt")

arr = raw.map {|line| line.split(" ") }

choices = { "X" => 0, "Y" => 3, "Z" => 6}
wins = { 0 => { "A" => 3, "B" => 1, "C" => 2 },
         3 => { "A" => 1, "B" => 2, "C" => 3 },
         6 => { "A" => 2, "B" => 3, "C" => 1 } }

result = 0
arr.each do |pair|
  result += choices[pair[1]]
  result += wins[choices[pair[1]]][pair[0]]
end

puts result