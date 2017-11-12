require "colorize"
#:nodoc:
class Error
  def input_check(exp)
    null_check(exp)
    check(exp)
  end

  def check(exp)
    operands = 0
    exp.each do |expr|
      case expr
      when /\d+/
        operands += 1
      end
    end
    arg_check(exp, operands)
  end

  def null_check(expres)
    if expres == "\="
      puts "Error. You must write expr.".red
      exit 1
    end
  end

  def op_check(exp)
    if exp != /\d+/ && exp != "/\+|\*|\/|\-|\!|\=/"
      puts "Error. Wrong expression, please use only numbers and symbols: +, *, /, -, !, =.".red
      exit 1
    end
  end

  def arg_check(exp, op)
    if exp.size / 2 != op || exp.size < 3
      puts "Error. Wrong number of arguments".red
      exit 1
    end
  end
end
