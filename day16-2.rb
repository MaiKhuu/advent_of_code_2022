class Room
  attr_accessor :rate, :exits
  def initialize(r, e)
    @rate = r
    @exits = e
  end
end

def parse_input(raw_input)
    result = {}
    
    raw_input.each do |line|
        elements = line.gsub(",","").split(" ")
        source, rate, exits = elements[1], elements[4][5..-2].to_i, elements[9..elements.size-1]
        result[source] = Room.new(rate, exits)
    end
    return result
end

def calculate_distances(all_rooms, key_rooms)
  distances = {}

  key_rooms.each do |start_room| 
    current_room = [start_room]
    next_room = []
    d = 0
    temp = [start_room, start_room]
    distances[temp] = 0
    while !current_room.empty?
      d += 1
      current_room.each do |from_room|
        all_rooms[from_room].exits.each do |to_room|
          temp = [start_room, to_room]
          if distances[temp].nil?
            distances[temp] = d
            next_room << to_room
          end
        end
      end
      current_room = next_room
      next_room = []
    end
  end

  return distances
end

def best_total_flow(all_rooms, distances, current_room, time, seen_rooms, remaining_rooms)
  seen_rooms = (seen_rooms + [current_room]).uniq
  remaining_rooms = remaining_rooms - seen_rooms  
  best_flow = 0
  
  remaining_rooms.each do |room|
    temp = [current_room, room]
    time_remaining = time - distances[temp] - 1
    if time_remaining > 0
      flow = time_remaining * all_rooms[room].rate
      flow += best_total_flow(all_rooms, distances, room, time_remaining, seen_rooms, remaining_rooms)
      best_flow = flow if best_flow < flow
    end
  end
  
  return best_flow
end

def set_avail(all_rooms, distances, master_flow_set, current_room, flow_current = 0, time, seen_rooms, key_rooms)
  seen_rooms = (seen_rooms + [current_room]).uniq.sort
  remaining_rooms = key_rooms - seen_rooms
  avail = (seen_rooms - ["AA"]).clone
  
  if master_flow_set.include?(avail)
    master_flow_set[avail] = [master_flow_set[avail], flow_current].max
  else
    master_flow_set[avail] = flow_current
  end
  
  best_flow = 0
  remaining_rooms.each do |room|
    temp = [current_room, room]
    time_left = time - distances[temp] - 1
    if time_left > 0
      flow_new = all_rooms[room].rate * time_left
      flow_new += set_avail(all_rooms, distances, master_flow_set, room, flow_current + flow_new, time_left, seen_rooms, key_rooms)
      best_flow = flow_new if best_flow < flow_new
    end
  end
  
  return best_flow
end

def complete_master_flow_set(master_flow_set, key_rooms, current_room)
  if !master_flow_set.include?(current_room.sort)
    best_flow = 0
    current_room.each do |e|
      subset = (current_room - [e]).sort
      new_flow = complete_master_flow_set(master_flow_set, key_rooms, subset)
      best_flow =  new_flow if best_flow < new_flow
    end
    master_flow_set[current_room] = best_flow
  end
  return master_flow_set[current_room]
end

raw_input = File.readlines("input.txt").map(&:chomp)
input = parse_input(raw_input)
key_rooms = input.select do |k, v|
              k == "AA" || v.rate > 0 
            end.keys

distances = calculate_distances(input, key_rooms)

master_flow_set = {}
set_avail(input, distances, master_flow_set, "AA", 0, 26, [], key_rooms)
complete_master_flow_set(master_flow_set, key_rooms, (key_rooms - ["AA"]))

best_flow = 0
master_flow_set.each do |human_work, v|
  elephant_work = (key_rooms - ["AA"] - human_work).sort
  next if master_flow_set[human_work].nil? || master_flow_set[elephant_work].nil?
  total_flow = master_flow_set[human_work] + master_flow_set[elephant_work]
  best_flow = total_flow if total_flow > best_flow
end

p best_flow