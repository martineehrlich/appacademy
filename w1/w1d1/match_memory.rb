class Card
  attr_accessor :value, :face_up

  def initialize(value)
    @value = value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def ==(other_card)
    return false unless other_card.is_a?(self.class)
    value == other_card.value
  end

end

class Board
  attr_accessor :board_size

  def initialize(difficulty)
    @board_size = difficulty
    @grid = Array.new (difficulty) { Array.new(difficulty) }
    number_of_cards = (difficulty ** 2) / 2
    @card_values = ((1..number_of_cards).to_a * 2).shuffle
    p @card_values
    populate
  end

  def populate
    @grid.each_index do |idx1|
      @grid[idx1].each_index do |idx2|
        @grid[idx1][idx2] = Card.new(@card_values.pop)
      end
    end
  end

  def render
    system("clear")
    @grid.each { |row| p display_row(row)}
  end

  def won?
    @grid.all? do |row|
      row.all? { |card| card.face_up }
    end
  end

  def [](row, column)
    @grid[row][column]
  end

  def []=(row, column, mark)
    @grid[row][column] = mark
  end

  def reveal(pos)
    self[*pos].reveal
  end

  def unmatched?(pos)
    if self[*pos].face_up
      p "Card already guessed. Please guess again:"
      return false
    end
    true
  end

  def valid_move?(pos)
    if pos[0].between?(0, board_size - 1) && pos[1].between?(0, board_size - 1)
      return true
    else
      puts "not a valid move, pick again"
      return false
    end
  end

  private
  attr_accessor :grid

  def display_row(row)
    return row.map{ |entry| entry.face_up ?  entry.value : 0 }
  end
end






class Game
  attr_accessor :guessed_pos, :previous_guess, :board, :board_size, :player

  def initialize(difficulty, player)
    @player = player
    @board = Board.new(difficulty)
    @previous_guess = nil
    @guessed_pos = nil
    @board_size = difficulty
    @turns = 0
  end

  def play
    until board.won? || @turns == (board_size ** 2) * 2
      board.render
      self.previous_guess = player.make_guess(@board)
      self.guessed_pos = player.make_guess(@board)

      check_match
      @turns += 1
    end
    @turns == (board_size ** 2) * 2 ? p("Sorry, you lose!") : p("Congrats, you win!")
  end



  def check_match
    first_guess = board[*previous_guess]
    second_guess = board[*guessed_pos]

    if first_guess == second_guess
      puts "yay, a match!"
    else
      board.render
      sleep(5)
      first_guess.hide
      second_guess.hide
      #system("clear")
      puts "incorrect guess, sorry!"
    end
  end


end

class HumanPlayer
  def initialize(name)
    @name = name
  end

  def prompt
    puts "Pick a row:"
    row = gets.chomp.to_i
    puts "Pick a column:"
    column = gets.chomp.to_i
    [row, column]
  end


  def make_guess(board)
    pos = nil
    until pos && board.valid_move?(pos) && board.unmatched?(pos)
      pos = prompt
    end
    board.reveal(pos)
    board.render
    pos
  end


end

class ComputerPlayer
  attr_accessor :memory
  def initialize(name)
    @name = name
    @memory = {}
  end

  def make_guess(board)
    memory.each do |key, value|
      if memory.values.count(value) == 2
        next if board[*key].face_up
        pos = key if board.unmatched?(key)
        board.reveal(pos)
        return pos
      end
    end
    pos = [rand(board.board_size), rand(board.board_size)]
    until  !memory.keys.include?(pos) && board.unmatched?(pos)
      pos = [rand(board.board_size), rand(board.board_size)]
    end
    memory[pos] = board[*pos].value
    board.reveal(pos)
    board.render
    pos
  end
end

p "Enter a difficulty setting by entering amount of rows"
rows = gets.chomp.to_i
until rows % 2 == 0
  p "Please enter an even number"
  rows = gets.chomp.to_i
end

game = Game.new(rows, HumanPlayer.new("Martine"))
game.play
