def find_adjacent_cubes(cube_arr)
    x, y, z = *cube_arr
    return [[x - 1, y, z], [x + 1, y, z], [x, y - 1, z], [x, y + 1, z], [x, y, z - 1], [x, y, z + 1]]
end

raw_input = File.readlines("input.txt").map(&:chomp)

cubes = raw_input.map { |line| line.split(",").map {|n| n.to_i}}
adjacent_cubes = cubes.map{ |p| find_adjacent_cubes(p) }

result = []
adjacent_cubes.each do |c_arr|
  c_arr.each do |c|
    result << c if !cubes.include?(c)
  end
end

p result.size