class Game
  attr_accessor :players, :board, :turn

  def initialize(player1, player2)
    @players = {:x => player1, :o => player2}
    @board = Board.new
    @turn = :x
  end

  def play
    puts "Welcome to Tic Tac Toe!"
    play_turn until board.won? == true
  end

  def play_turn
    if board.check_draw == true
      board.won? == true
    end
    puts "It's #{players[turn].name} turn!"
    puts "Where do you want to move?"
    board.display
    pos = players[turn].make_move(board, turn)
    board.place_move(pos, turn)
    if board.won? == true
      board.display
      puts "#{players[turn].name} won!"
    end
    @turn == :x ? @turn = :o : @turn = :x
  end

end

class Board
  attr_accessor :rows, :columns, :diagonals, :winning_array, :all_options

  def self.blank_grid
    Array.new(3) { Array.new(3) }
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
    @winning_array = [[:x, :x, :x], [:o, :o, :o]]
  end

  def columns
    @columns = @rows.transpose
  end

  def place_move(pos, mark)
    self[*pos] = mark
  end

  def diagonals
    @diagonals = [[self[0, 0], self[1, 1], self[2, 2]], [self[2, 0], self[1, 1], self[0, 2]]]
  end

  def [](row, col)
    @rows[row][col]
  end

  def []=(row, col, mark)
    @rows[row][col] = mark
  end

  def display
    rows.each { |row| p row }
  end

  def dup
    duped_rows = rows.map(&:dup)
    self.class.new(duped_rows)
  end

  def check_draw
    return true if !rows.include?(nil)
  end


  def won?
    @all_options = rows + columns + diagonals
    return true if all_options.include?(winning_array[0]) || all_options.include?(winning_array[1])
  end

  def empty?(pos)
    if self[*pos] == nil
      return pos
    else
      return false
    end
  end

    def place_mark(pos, mark)
      self[*pos] = mark
    end

  end

  class ComputerPlayer
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def make_move(board, mark)
    if winning_move(board, mark) == false
      random_move(board, mark)
    else
      winning_move(board, mark)
    end
  end

  def random_move(board, mark)
    row = rand(3)
    col = rand(3)
    pos = [row, col]
  if board.empty?(pos) == pos
      pos
  else
    self.make_move(board, mark)
  end
end

  def winning_move(board, mark)
    (0..2).each do |row|
      (0..2).each do |col|
        checking_board = board.dup
        pos = [row, col]
      next unless checking_board.empty?(pos) == pos
        checking_board[*pos] = mark
        return pos if checking_board.won?
    end
  end
  false
end


  end

  class HumanPlayer

    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def make_move(board, mark)
      puts "Enter a row"
      row = gets.chomp.to_i
      puts "Enter a column"
      column = gets.chomp.to_i
      if row.between?(0,2) && column.between?(0,2)
        pos = [row, column]
        if board.empty?(pos) == pos
          pos
        else
          puts "that space is full"
          self.make_move(board, mark)
        end
      else
        puts "that is not a valid move"
        self.make_move(board, mark)
      end
    end

  end

  player1 = HumanPlayer.new("Martine")
  player2 = ComputerPlayer.new("Computer")
  game = Game.new(player1, player2)
  game.play
