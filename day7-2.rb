raw_input = File.readlines("input.txt").map(&:chomp)

folders = [[]]
size = {}

raw_input.each do |line|
  if line.start_with?("$ cd ..")
    folders.pop
  elsif line.start_with?("$ cd ")
    new_folder = line.delete_prefix("$ cd ")
    parent_folder = folders.last 
    new_folder_path = parent_folder + [new_folder]
    folders << new_folder_path
  else
    file_size = line.split(" ").first.to_i
    folders.each do |path|
      if size[path].nil?
        size[path] = file_size
      else
        size[path] += file_size
      end
    end
  end
end

need_to_delete = 30000000 - (70000000 - size[[]])
result = nil
size.each_value do |s|
  if s >= need_to_delete
    if result.nil?
      result = s
    else 
      result = s if result > s
    end
  end
end
p result