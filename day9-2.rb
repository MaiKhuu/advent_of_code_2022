def move_type(move)
  case move
    when 'R'
      return [0,1]
    when 'L'
      return [0,-1]
    when 'U'
      return [1,0]
    when 'D'
      return [-1,0]
  end
end

def touch?(one, two)
  return true if (one[0] == two[0] && (one[1] - two[1]).abs == 1) ||
                 (one[1] == two[1] && (one[0] - two[0]).abs == 1) || 
                 ((one[0] - two[0]).abs == 1 && (one[1] - two[1]).abs == 1) || 
                 (one == two)
end

def up_or_down?(one, two) # return 1 if two is up, -1 if two is down, false otherwise
  return 1 if one[0] == two[0] && two[1] - one[1]== 2
  return -1 if one[0] == two[0] && two[1] - one[1]== -2
  false
end

def left_or_right?(one, two) # return 1 if two is right, -1 if two is left, false otherwise
  return 1 if one[1] == two[1] && two[0] - one[0] == 2
  return -1 if one[1] == two[1] && two[0] - one[0] == -2
  false
end

def diagnonal?(one,two) # return [horizonal, vertical] move if exists, falst otherwise
  vertical_move = two[1] - one[1] # 1 if shift right, -1 if shift left
  horizontal_move = two[0] - one[0] # 1 if shift up, -1 if shift down
  return false if vertical_move.abs > 2 || horizontal_move.abs > 2
  horizontal_move /= 2 if horizontal_move.abs != 1
  vertical_move /= 2 if vertical_move.abs != 1
  [horizontal_move, vertical_move]
end

def move(tail, head)
  return tail.clone if touch?(tail, head)
  return [tail[0], tail[1] + up_or_down?(tail, head)] if up_or_down?(tail, head)
  return [tail[0] + left_or_right?(tail, head), tail[1]] if left_or_right?(tail, head)
  return [tail[0] + diagnonal?(tail, head)[0], tail[1] + diagnonal?(tail, head)[1], ]if diagnonal?(tail, head)
  false
end

raw_input = File.readlines("input.txt").map(&:chomp)

visited = []
snake = [[1,1]] * 10 # snake[9] is head, snake[0] is tail

raw_input.each do |line|
  move, num = line.split(" ")
  pattern = move_type(move)
  num.to_i.times do 
    snake[9] = [snake[9][0] + pattern[0], snake[9][1] + pattern[1]]
    (0..8).to_a.reverse.each do |i|
      snake[i] = move(snake[i], snake[i+1])
    end
    visited << snake[0] 
  end
end

p visited.uniq.size