MAX = 100000

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

result = 0
size.each { |path, s| result +=s if s <= MAX} 

p result