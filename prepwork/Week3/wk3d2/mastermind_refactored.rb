require 'colorize'

class Game

  def initialize
    @count = 0
    @secret_code = Code.random
    @guess_code = Code.new([])
  end

  def play
    play_turn until game_over?
    if @count > 10
      puts "out of guesses, game over"
    else
      puts "you win!"
    end
  end

  def game_over?
    won? || @count > 10
  end

  def play_turn
    while self.won? != true && @count < 11
      @guess_code = get_code
      puts @guess_code.code_to_colors
      puts "Exact matches: #{@secret_code.exact_matches(@guess_code)}"
      puts "Near matches: #{@secret_code.near_matches(@guess_code)}"
       @count += 1
    end
  end

  def get_code
    guess = ""
    until Code.valid?(guess)
      p "enter your code in RRRR format"
      guess = gets.chomp
    end
    Code.new(guess.upcase.split(""))
  end

  def won?
    return true if @secret_code.exact_matches(@guess_code) == 4
  end

end

class Code
  attr_accessor :code, :colors

  COLORS = ["R", "G", "B", "Y", "T", "P"]

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
    @colors = ["R", "G", "B", "Y", "T", "P"]
  end

  def [](idx)
    @code[idx]
  end


  def code_to_colors
    colors_hash = {"R" => "red".red, "G" => "green".green, "B" => "blue".blue,
    "Y" => "yellow".yellow, "T" => "turquoise".cyan, "P" => "purple".magenta}
  output =  code.map { |el| colors_hash[el] }
    output.join(" ")


  end

  def exact_matches(other_code)
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

game = Game.new
game.play
