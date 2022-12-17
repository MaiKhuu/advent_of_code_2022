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

raw_input = File.readlines("input.txt").map(&:chomp)
input = parse_input(raw_input)
key_rooms = input.select do |k, v|
              k == "AA" || v.rate > 0 
            end.keys

distances = calculate_distances(input, key_rooms)


p best_total_flow(input, distances, "AA", 30, [], key_rooms)