def visible_top(grid, r, c)
  return true if r.zero?
  r.times {|i| return false if grid[r][c] <= grid[i][c]}
  true
end

def visible_right(grid, r, c)
  w = grid.first.size-1
  return true if c == w
  (w-c).times {|i| return false if grid[r][c] <= grid[r][w-i]}
  true
end

def visible_bottom(grid, r, c)
  h = grid.size-1
  return true if r == h
  (h-r).times {|i| return false if grid[r][c] <= grid[h-i][c]}
  true
end

def visible_left(grid, r, c)
  return true if c.zero?
  c.times {|i| return false if grid[r][c] <= grid[r][i]}
  true
end

input = File.readlines("input.txt").map(&:chomp).map(&:chars).map{|line| line.map(&:to_i)}

result= 0
for i in 0..input.size-1 do 
  for j in 0..input.first.size-1 do
    result += 1 if visible_top(input, i, j) || visible_right(input, i, j) || visible_bottom(input, i, j) || visible_left(input, i, j)
  end
end

p result
