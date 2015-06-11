class Game
  def initialize
    @count = 0
    @secret_code = Code.random
    @guess_code = Code.new([])
  end

  def play
    play_turn until game_over?
    declare_game_over
  end

  def game_over?
    won? || @count > 10
  end

  def play
    while self.won? != true && @count < 11
      @guess_code = get_code
      puts "Exact matches: #{@secret_code.exact_matches(@guess_code)}"
      puts "Near matches: #{@secret_code.near_matches(@guess_code)}"
       @count += 1
       # @guess_code.code = @guess_code.player_code
    end

    if @count > 10
      puts "GAME OVER"
    end
  end

  def get_code
    guess = ""
    until Code.valid?(guess)
      p "enter your code in RRRR format"
      guess = gets.chomp
    end
    @guess_code = Code.new(guess.upcase.split(""))
  end

  def won?
    if @secret_code.exact_matches(@guess_code) == 4
      puts "YAY YOU WIN"
      return true
    end
  end
end

class Code
  attr_accessor :code, :colors

  COLORS = ["R", "G", "B", "Y", "O", "P"]

  def self.random
    code = []
    4.times { code << COLORS.sample }
    Code.new(code)
  end

  def self.valid?(colors)
    colors.length == 4 && colors.upcase.split("").all? { |i| COLORS.include?(i) }
  end

  def initialize(code)
    @code = code
    @colors = ["R", "G", "B", "Y", "O", "P"]
  end

  def [](idx)
    @code[idx]
  end

  def exact_matches(other_code)
    p other_code.code
    matches = 0
    @idx_matches = {}
    @code.each_index do |i|
      if @code[i] == other_code[i]
        @idx_matches[i] = i
        matches += 1
      end
    end

    matches
  end

  def near_matches(other_code)
    matches = 0
    @code.each_index do |i|
      other_code.code.each_index do |idx|
        next if @idx_matches.include?(i) || @idx_matches.values.include?(idx)
        if @code[i] == other_code.code[idx]
          matches += 1
          @idx_matches[i] = idx
        end
    end
  end
  matches
  end

end
