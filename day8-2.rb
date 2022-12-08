def count_visible_top(grid, r, c)
  return 0 if r.zero?
  (0..r-1).to_a.reverse.each {|i| return (r-i) if grid[r][c] <= grid[i][c]}
  r
end

def count_visible_right(grid, r, c)
  w = grid.first.size-1
  return 0 if c == w
  (1..w-c).to_a.each {|i| return i if grid[r][c] <= grid[r][c+i]}
  w-c
end

def count_visible_bottom(grid, r, c)
  h = grid.size-1
  return 0 if r == h
  (1..h-r).to_a.each {|i| return i if grid[r][c] <= grid[r+i][c]}
  h-r
end

def count_visible_left(grid, r, c)
  return 0 if c.zero?
  (0..c-1).to_a.reverse.each {|i| return c-i if grid[r][c] <= grid[r][i]}
  c
end

def scenic_score(grid, r, c)
  count_visible_top(grid, r, c) * count_visible_right(grid, r, c) * count_visible_bottom(grid, r, c) * count_visible_left(grid, r, c)
end

input = File.readlines("input.txt").map(&:chomp).map(&:chars).map{|line| line.map(&:to_i)}
result = 0
for i in 0..input.size-1 do 
  for j in 0..input.first.size-1 do
    result = scenic_score(input, i, j) if scenic_score(input, i, j) > result
  end
end

p result

