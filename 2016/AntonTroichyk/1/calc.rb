stack = []
loop do
  tmp = gets.chomp
  case tmp
  when /\d/
    stack.push(tmp.to_f)
  when "-"
    if stack.size < 2
      puts "error: dont have 2 operands before -"
      break
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 - operand_2)
  when "+"
    if stack.size < 2
      puts "error: dont have 2 operands before +"
      break
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 + operand_2)
  when "*"
    if stack.size < 2
      puts "error: dont have 2 operands before *"
      break
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 * operand_2)
  when "/"
    if stack.size < 2
      puts "error: dont have 2 operands before /"
      break
    end
    operand_2 = stack.pop
    operand_1 = stack.pop
    stack.push(operand_1 / operand_2)
  when "="
    result = stack.pop
    puts result
    break
  end
end
