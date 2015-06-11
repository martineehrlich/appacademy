class RPNCalculator
  def initialize
    @store = Array.new
  end

  def push(n)
    @store.push(n)
  end

  def value
    @store.last
  end

  def tokens(input)
    input.split(' ').map { |item| item.to_i == 0 ? item.to_sym : item.to_i }
  end

  def evaluate(input)
    tokens(input).each{ |item| item.is_a?(Fixnum) ? push(item) : operate(item) }
    value
  end

  def operate(operator)
    raise "calculator is empty" if @store.length < 2
    second_num = @store.pop
    first_num = @store.pop

    result = first_num.send(operator, second_num)
    @store.push(result)
  end
end

if ARGV.empty?
  input = ""
  $stdin.each do |token|
    input += ' ' + token
    break if token == "\n"
  end
else
  input = File.readlines(ARGV[0]).first
end
