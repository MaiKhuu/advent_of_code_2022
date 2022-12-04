def input
  File.readlines("input.txt").map(&:chomp).map do |line|
    line.split(",").map do |pair|
      pair.split("-").map(&:to_i)
    end
  end
end

def starter_ordering(line)
  if line[0][0] <= line[1][0]
    line
  else
    line.reverse
  end
end

def overlap?(range1, range2)
  return true if (range1[1]>=range2[0]) && (range1[0] <= range2[1])
  false
end

p input.map { |line| starter_ordering(line)}.map { |line| overlap?(*line) }.count{ |result| result}