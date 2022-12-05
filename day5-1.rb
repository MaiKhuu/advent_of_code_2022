def parse_sections
  raw = File.readlines('input.txt').map(&:chomp)
  raw_crates_input = []
  raw_moves = []
  switch = false
  raw.each do |line|
    if line.empty? 
      switch = true
      next
    end
    if switch 
      raw_moves << line
    else
      raw_crates_input << line
    end
  end
  return raw_crates_input, raw_moves
end

def parse_crates(raw_input)
  raw_input.reverse!
  count = raw_input.first.split.map(&:to_i).max
  result = []
  count.times { result << [] }
  raw_input.delete_at(0)
  raw_input.each do |line|
    line.chars.each_with_index do |c, i|
      next unless (i % 4 == 1)
      next unless c != " "
      j = i / 4
      result[j] << c
    end
  end
  result
end

def parse_moves(raw_input)
  result = []
  raw_input.each do |line|
    line.slice!("move ")
    line.slice!("from ")
    line.slice!("to ")
    moves = line.split(" ").map(&:to_i)
    result << [moves[0], moves[1] - 1, moves[2] - 1]
  end
  result
end

def full_parse_procesure
  raw_crates_input, raw_moves_input = parse_sections
  return parse_crates(raw_crates_input), parse_moves(raw_moves_input)
end

def move_1_from_a_to_b(crates, a, b)
  item = crates[a].delete_at(crates[a].size - 1)
  crates[b] << item
end

def all_moves_done(crates, moves)
  moves.each do |line|
    line[0].times do 
      move_1_from_a_to_b(crates, line[1], line[2])
    end
  end
end

crates, moves = full_parse_procesure
all_moves_done(crates, moves)
result = crates.map{ |line| line.last }.join

p result