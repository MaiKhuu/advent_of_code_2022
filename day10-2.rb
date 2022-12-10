def move_sprite(head, num)
  starter = head + num
  # starter = 37 if starter > 37
  # starter = 0 if starter < 0
  temp = ["."] * 40
  3.times { |i| temp[starter + i] = "#" }
  return temp, starter
end

def find_pixel_on_sprite(arr, cycle)
  return arr[(cycle % 40)-1]
end

def crt_line(cycle)
  return ((cycle - 1) / 40)
end

def display(crt)
  crt.each do |line|
    puts line.join
  end
  puts ""
end

raw_input = File.readlines("input.txt").map(&:chomp)
sprite = ["#"]*3 + ["."]*37
sprite_head = 0
crt = [[],[],[],[],[],[]]
cycle_count = 0

raw_input.each do |line|
  num = line.split(" ")[1].to_i
  cycle_count += 1
  # p "crt line is #{crt_line(cycle_count)}, cycle is #{cycle_count}, pixel is #{find_pixel_on_sprite(sprite, cycle_count)} "
  crt[crt_line(cycle_count)] << find_pixel_on_sprite(sprite, cycle_count)
  
  next if num.zero?
  
  cycle_count += 1
  crt[crt_line(cycle_count)] << find_pixel_on_sprite(sprite, cycle_count)
  sprite, sprite_head = move_sprite(sprite_head, num)
end

display(crt)