def input
  File.readlines("input.txt").map(&:chomp).map do |line|
    line.split(",").map do |pair|
      pair.split("-").map(&:to_i)
    end
  end
end

def range_size(pair)
  pair[1] - pair[0] + 1
end

def inclusive_ordering(line)
  smaller, larger = if range_size(line[0]) <= range_size(line[1])
                      line
                    else
                      line.reverse
                    end
end

def inclusive?(range1, range2)
  return true if (range1[0]>=range2[0]) && (range1[1]<=range2[1])
  false
end

raw = input
p input.map { |line| inclusive_ordering(line)}.map { |line| inclusive?(*line) }.count{ |result| result}