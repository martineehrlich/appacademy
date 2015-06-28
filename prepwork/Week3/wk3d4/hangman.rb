class ComputerPlayer
  attr_accessor :secret_word, :dictionary, :guesses

  def initialize(name)
    @name = name
    @dictionary = []
    @guessed_letters = []
    @opponent_letters = []
  end

  def receive_secret_length(word_length)
    @dictionary = Array.new(File.read("dictionary.txt").split("\n")).select do |line|
      line.chomp.length == word_length
    end
  end

  def pick_secret_word
    @secret_word = File.readlines("dictionary.txt").sample.chomp
    @secret_word.length
  end

  def handle_guess_response(indices, letter)
    filter(letter, indices)
  end

  def pick_most_common_letter
    @string_dictionary = (@dictionary.map { |word| word.split("")}).flatten
    count = Hash.new(0)
    @string_dictionary.each {|letter| count[letter] += 1}
    most_common_letters = count.sort_by { |k,v| v }.reverse
    most_common_letters.delete_if {|k,v| @guessed_letters.include?(k)}
    @guessed_letters << most_common_letters.to_a.first[0]
      most_common_letters.to_a.first[0]
  end

  def guess
    pick_most_common_letter
  end

  def filter(letter, indices)
    if indices.length > 0
      filter_partial_matches(letter, indices)
    else
      filter_non_matches(letter)
    end
  end

  def filter_non_matches(letter)
    @dictionary.select! { |word| !(word.split("").include?(letter)) }
  end

  def filter_partial_matches(letter, indices)
    @dictionary.select! do |word|
      indices.all? { |idx| word.split("")[idx] == letter }
    end
  end

  def check_guess(letter)
    indices = []
    @secret_word.split("").each_with_index do |el, idx|
      indices << idx if el == letter
    end
    indices
  end

  def game_won(letter)
    @opponent_letters << letter
    if @secret_word.split("").all? {|l| @opponent_letters.include?(l) }
      puts "You guessed my word, '#{@secret_word}'"
      return true
    elsif @opponent_letters.length == 15
      puts "out of guesses, you lose"
      puts "my word was: #{secret_word}"
      return true
    else
      return false
    end
  end

end


class Hangman
  attr_accessor :guessing_player, :checking_player, :letter

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end


  def play
    puts "Welcome to Hangman!"
    guessing_player.receive_secret_length(checking_player.pick_secret_word)

    while game_over? != true
      @letter = guessing_player.guess
      indices = checking_player.check_guess(letter)
      guessing_player.handle_guess_response(indices, letter)
    end
  end
  
  def game_over?
      checking_player.game_won(letter)
  end
end



  class HumanPlayer
    attr_accessor :guessed_letters, :display_string, :secret_word, :opponent_guesses, :matches

    def initialize(name)
      @name = name
      @guessed_letters = []
      @opponent_guesses = []
      @alphabet = ("a".."z").to_a
      @matches = []
    end

    def guess
      puts "secret word: #{display_string.join(" ")}"
      puts "guessed letters: #{guessed_letters.join(" ")}"
      puts "pick a letter"
      letter = gets.chomp
      if @guessed_letters.include?(letter)
        puts "you already guessed that letter silly!"
        self.guess
      elsif !@alphabet.include?(letter)
        puts "that is not valid input"
        self.guess
      else
        return letter
      end
    end

    def pick_secret_word
      puts "enter word length"
      @secret_word = gets.chomp.to_i
    end

    def receive_secret_length(word_length)
      @display_string = Array.new(word_length) { "_" }
    end

    def handle_guess_response(indices, letter)
      indices.each { |i| display_string[i] = letter}
      guessed_letters << letter
    end

    def game_won(letter)
      @opponent_guesses << letter

      if matches.length == secret_word
        puts "you win!"
        return true
      elsif @opponent_guesses.length == 15
        puts "out of guesses, you lose"
        return true
      end
    end

    def check_guess(letter)
      puts "is #{letter} included in your word? if yes, enter indices where your letter occurs"
      puts "for example, if your word is 'book' and your letter is 'o' enter 12"
      puts "answer 'no' if the letter is not included in your word"
      input = gets.chomp
      if input == "no"
        return []
      else
      correct_indices = input.split("").map {|i| i.to_i}
      matches += correct_indices
      correct_indices
      end
    end
  end

  c1 = ComputerPlayer.new("computer1")
  c2 = HumanPlayer.new("computer2")

  game = Hangman.new(c1, c2)
  game.play
