def solve(monkeys, name)
  if monkeys[name].kind_of?(Integer)
    return monkeys[name]
  else
    operator = monkeys[name][1]
    case operator
      when "+"
        return solve(monkeys, monkeys[name][0]) + solve(monkeys, monkeys[name][2])
      when "-"
        return solve(monkeys, monkeys[name][0]) - solve(monkeys, monkeys[name][2])
      when "*"
        return solve(monkeys, monkeys[name][0]) * solve(monkeys, monkeys[name][2])
      when "/"
        return solve(monkeys, monkeys[name][0]) / solve(monkeys, monkeys[name][2])
    end
  end
end

raw_input = File.readlines("input.txt").map(&:chomp)
monkeys = {}

raw_input.each do |line|
  line = line.gsub(":","").split(" ")
  if line.size == 2
    monkeys[line[0]] = line[1].to_i
  else
    monkeys[line.first] = line[1..line.size-1]
  end
end

p solve(monkeys, "root")