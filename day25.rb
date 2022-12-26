def parse_snafu_input(input)
  num = []
  input.each do |line|
    num << []
    line.chars.each do |c|
      if c == "-"
        num.last << -1
      elsif c == "="
        num.last << -2
      else
        num.last << c.to_i
      end
    end
    num.last.reverse!
  end
  num
end

def mutiple_of_five(count)
  result = [1]
  (count-1).times do 
    result << result.last * 5
  end
  result
end

def to_decimal(num_arr, multiplier)
  result = 0
  num_arr.each_with_index do |n, i|
    result += n * multiplier[i]
  end
  result
end

def to_base_five(num)
  result = []
  while !num.zero?
    result << num % 5
    num /= 5
  end
  result.reverse
end
  
def to_snafu(num, multiplier)
  result = to_base_five(num)
  return result.join if result.none?{ |c| !(0..2).cover?(c) }
  adder = to_decimal([2] * result.size, multiplier)
  num += adder
  result = to_base_five(num)
  # p result
  result = result.map{ |n| n - 2 } 
  result[0] = result[0].abs
  final_result = []
  result.each do |n|
    if n == -1
      final_result << "-"
    elsif n == -2
      final_result << "="
    else
      final_result << n
    end
  end
  return final_result.join
end

raw_input = File.readlines("input.txt").map(&:chomp)

snafu_num = parse_snafu_input(raw_input)
multiplier = mutiple_of_five(30)
sum = snafu_num.map { |n| to_decimal(n, multiplier) }.sum
puts to_snafu(sum, multiplier)