def solve_human(monkeys, name)
  return name if name == "humn" 
  return monkeys[name] if monkeys[name].kind_of?(Integer)
  op = monkeys[name][1]
  left_item = monkeys[name][0]
  right_item = monkeys[name][2]
  if left_item.kind_of?(Integer) && right_item.kind_of?(Integer)
    return calculate(left_item, op, right_item) 
  end
  return [solve_human(monkeys, left_item), monkeys[name][1], solve_human(monkeys, right_item)]
end

def calculate(num1, op, num2)
  return [num1, op, num2] if (num1=="humn" && num2.kind_of?(Integer)) || (num1.kind_of?(Integer) && num2=="humn")
  if num1.kind_of?(Integer) && num2.kind_of?(Integer)
    case op
      when "+"
        num1 + num2
      when "-"
        num1 - num2
      when "*"
        num1 * num2
      when "/"
        num1 / num2
    end
  else
    return num1, op, num2
  end
end

def calculate_expression(e)
  return e if e.kind_of?(Integer)
  return calculate(*e) if e[0].kind_of?(Integer) && e[2].kind_of?(Integer)
  if !e[0].kind_of?(Integer) && !e[2].kind_of?(Integer)
    return calculate(calculate_expression(e[0]), e[1], calculate_expression(e[2]))
  elsif e[0].kind_of?(Integer)
    return calculate(e[0], e[1], calculate_expression(e[2]))
  else
    return calculate(calculate_expression(e[0]), e[1], e[2])
  end
end

def condense_equation(expression)
  return "humn" if expression == "humn"
  return expression if expression.kind_of?(Integer)

  left, op, right = *expression
  if (left.kind_of?(Integer) && right.kind_of?(Integer)) || (left.kind_of?(Integer) && right == "humn") || (right.kind_of?(Integer) && left == "humn")
    return calculate(left, op, right)
  else 
    return calculate(condense_equation(left), op, condense_equation(right))
  end
end

def solve(num, equation)
  return num if equation == "humn"
  
  left, op, right = *equation
  human_side = nil
  num_side = nil
  
  if left.kind_of?(Integer)
    human_side = "right"
    equation = right
    num_side = left
  elsif right.kind_of?(Integer)
    human_side = "left"
    equation = left
    num_side = right
  end
    
  case op
    when "+"
      solve(num - num_side, equation)
    when "*"
      solve(num / num_side, equation)
    when "-"
      human_side == "left" ? solve(num + num_side, equation) : solve(num_side - num, equation)
    when "/"
      human_side == "left" ? solve(num * num_side, equation) : solve(num_side / num, equation)
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

left_side = solve_human(monkeys, monkeys["root"][0])
right_side = solve_human(monkeys, monkeys["root"][2])

num_to_solve = nil
equation = nil

if left_side.flatten.include?("humn")
  equation = condense_equation(left_side)
  num_to_solve = calculate_expression(right_side)
else
  equation = condense_equation(right_side)
  num_to_solve = calculate_expression(left_side)
end

p solve(num_to_solve, equation)