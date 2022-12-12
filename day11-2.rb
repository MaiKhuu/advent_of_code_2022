class Monkey
  attr_accessor :index, :items, :count
  @@lcm = 1
  @@lcm_multiples = []
  
  def self.show
    p @@lcm_multiples
  end
  
  def self.generate_lcm_multiples
    multiplier = 1
    10.times do 
      @@lcm_multiples << @@lcm * multiplier
      multiplier *= 10
    end
  end
  
  def initialize(text)
    @index = text[0].gsub("Monkey ", "").gsub(":","").to_i
    @items = text[1].gsub("Starting items: ","").split(",").map(&:to_i)
    @operator = text[2].strip.gsub("Operation: new = old ",'')[0]
    @operand = text[2].gsub("Operation: new = old ",'').gsub(@operator, "").strip
    @divisible_by = text[3].gsub("  Test: divisible by ","").to_i
    @true_move = text[4].gsub("If true: throw to monkey ","").to_i
    @false_move = text[5].gsub("If false: throw to monkey ","").to_i
    @count = 0
    
    @@lcm *= @divisible_by
  end
  
  def reduce(num)
    temp = num
    count = 9
    while count >=0 do 
      temp -= @@lcm_multiples[count] while temp > @@lcm_multiples[count] 
      count -= 1
    end
    temp
  end
  
  def operates(num)
    oper = (@operand == "old" ? num : @operand.to_i )
    temp = case @operator
      when "+"
        (num + oper)
      when "-"
        (num - oper)
      when "*"
        (num * oper) 
      when "/"
        (num / oper )
    end
    reduce(temp)
  end
  

  
  def passed_test?(num)
    num % @divisible_by == 0
  end
  
  def next_monkey(condition)
    condition ? @true_move : @false_move 
  end
  
  def play_one_game(num)
    @count += 1
    next_monkey(passed_test?(operates(num)))
  end
  
  def remove_item(item_num)
    @items.delete(item_num)
  end
  
  def recieve_item(item_num)
    @items << item_num
  end
  
  def sort_items
    @items.sort!
  end
end

def parse_each_monkey(input)
  result = [[]]
  input.each_with_index do |line, i|
    (i + 1) % 7 == 0 ? result << [] : result.last << line
  end
  result
end

def one_round(monkeys)
  monkeys.size.times do |i|
  items_to_remove = []
  
  monkeys[i].items.each do |it|
    new_worry_level = monkeys[i].operates(it)
    next_monkey = monkeys[i].play_one_game(it)
    items_to_remove << it
    monkeys[next_monkey].recieve_item(new_worry_level)
  end
  items_to_remove.each { |it| monkeys[i].remove_item(it) }
end
end

raw_input = parse_each_monkey(File.readlines("input.txt").map(&:chomp))
monkeys = []
raw_input.each {|info| monkeys << Monkey.new(info) }
Monkey.generate_lcm_multiples

10000.times { one_round(monkeys) }

orders = monkeys.map { |m| m.count }.sort.reverse

p orders[0] * orders[1]
