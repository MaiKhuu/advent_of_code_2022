def find_adjacent_cubes(cube_arr)
    x, y, z = *cube_arr
    return [[x - 1, y, z], [x + 1, y, z], [x, y - 1, z], [x, y + 1, z], [x, y, z - 1], [x, y, z + 1]]
end

def find_max(arr, i)
  arr.map { |e| e[i] }.max
end

def find_min(arr, i)
  arr.map { |e| e[i] }.min
end

raw_input = File.readlines("input.txt").map(&:chomp)

cubes = raw_input.map { |line| line.split(",").map {|c| c.to_i}}
adjacent_cubes = cubes.map{ |p| find_adjacent_cubes(p) }

max_x = find_max(cubes, 0)
max_y = find_max(cubes, 1)
max_z = find_max(cubes, 2)

min_x = find_min(cubes, 0)
min_y = find_min(cubes, 1)
min_z = find_min(cubes, 2)

outside_lava = [[min_x - 1, min_y - 1, min_z - 1]]
to_be_searched = [[min_x - 1, min_y - 1, min_z - 1]]

while !to_be_searched.empty?
  current_cube = to_be_searched.pop
  find_adjacent_cubes(current_cube).each do |c|
    x, y, z = *c
    if (min_x-1..max_x+1).cover?(x) && (min_y-1..max_y+1).cover?(y) && (min_z-1..max_z+1).cover?(z) && !cubes.include?(c) && !outside_lava.include?(c)
      outside_lava << c
      to_be_searched << c
    end
  end
end

result = []
adjacent_cubes.each do |cube_arr|
  cube_arr.each do |c|
    result << c if outside_lava.include?(c)
  end
end

p result.size
